package com.team5.secondhand.application.member.controller;

import com.team5.secondhand.application.member.domain.BasedRegion;
import com.team5.secondhand.application.member.domain.Oauth;
import com.team5.secondhand.application.member.domain.OauthEnv;
import com.team5.secondhand.application.member.dto.request.MemberJoin;
import com.team5.secondhand.application.member.dto.request.MemberLogin;
import com.team5.secondhand.application.member.dto.request.MemberProfileImageUpdate;
import com.team5.secondhand.application.member.dto.request.MemberRegion;
import com.team5.secondhand.application.member.dto.response.MemberDetails;
import com.team5.secondhand.application.member.dto.response.MemberDetailsWithToken;
import com.team5.secondhand.application.member.exception.MemberException;
import com.team5.secondhand.application.member.service.MemberService;
import com.team5.secondhand.application.oauth.dto.UserProfile;
import com.team5.secondhand.application.oauth.service.OAuthService;
import com.team5.secondhand.application.region.domain.Region;
import com.team5.secondhand.application.region.exception.EmptyBasedRegionException;
import com.team5.secondhand.application.region.exception.NoMainRegionException;
import com.team5.secondhand.application.region.exception.NotValidRegionException;
import com.team5.secondhand.application.region.service.GetValidRegionsUsecase;
import com.team5.secondhand.api.aws.dto.response.ProfileImageInfo;
import com.team5.secondhand.api.aws.exception.ImageHostException;
import com.team5.secondhand.api.aws.service.usecase.ProfileUpload;
import com.team5.secondhand.global.model.GenericResponse;
import com.team5.secondhand.global.jwt.service.JwtService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

import static com.team5.secondhand.application.member.exception.MemberExceptionHandler.JOIN_SESSION_KEY;

@Slf4j
@RestController
@RequiredArgsConstructor
public class MemberController {
    private final OAuthService oAuthService;
    private final MemberService memberService;
    private final ProfileUpload profileUpload;
    private final GetValidRegionsUsecase validRegions;
    private final JwtService jwtService;

    @Operation(
            summary = "회원가입",
            tags = "Members",
            description = "사용자는 회원가입을 할 수 있다."
    )
    @PostMapping("/join")
    public GenericResponse<Long> join(@RequestBody MemberJoin request, HttpSession session) throws MemberException, NotValidRegionException, NoMainRegionException {
        UserProfile tempMember = (UserProfile) session.getAttribute(JOIN_SESSION_KEY);
        Oauth joinPlatform = Oauth.NONE;

        if (tempMember == null) {
            memberService.isValidMemberId(request.getMemberId());
        } else {
            joinPlatform = Oauth.GITHUB;
            memberService.checkDataCorruption(request, tempMember);
            session.invalidate();
        }

        Map<Region, Boolean> basedRegions = BasedRegion.mapping(validRegions.getRegions(request.getRegionsId()), request.getRegions());
        Long joinedId = memberService.join(request, basedRegions, joinPlatform);

        return GenericResponse.send("Member joined Successfully", joinedId);
    }

    @Operation(
            summary = "아이디 중복검사",
            tags = "Members",
            description = "사용자는 회원가입 하기 위해서 아이디 중복검사를 해야한다."
    )
    @GetMapping("/join/availability")
    public GenericResponse<Boolean> checkDuplicateId(String memberId) {
        Boolean isDuplicate = memberService.isExistMemberId(memberId, Oauth.NONE);
        return GenericResponse.send("아이디 중복검사", isDuplicate);
    }


    @Operation(
            summary = "로그인",
            tags = "Members",
            description = "사용자는 로그인을 할 수 있다."
    )
    @PostMapping("/login")
    public GenericResponse<MemberDetails> login(@RequestBody MemberLogin request, HttpServletResponse response) throws MemberException, EmptyBasedRegionException, IOException {
        MemberDetails member = memberService.login(request);
        String token = jwtService.setTokenHeader(member, response);

        return GenericResponse.send("Member login Successfully", new MemberDetailsWithToken(member, token));
    }

    @Operation(
            summary = "깃허브 로그인",
            tags = "Members",
            description = "사용자는 깃허브로 로그인을 할 수 있다."
    )
    @GetMapping("/git/login")
    public GenericResponse<MemberDetails> getGithubUser(String code, String env, HttpServletResponse response) throws MemberException, EmptyBasedRegionException, IOException {
        UserProfile profile = oAuthService.getGithubUser(code, OauthEnv.valueOf(env));
        MemberDetails member = memberService.loginByOAuth(profile);
        jwtService.setTokenHeader(member, response);

        return GenericResponse.send("Member login Successfully", member);
    }

    @Operation(
            summary = "프로필 사진 변경",
            tags = "Members",
            description = "사용자는 자신의 프로필 사진을 변경할 수 있다."
    )
    @PatchMapping(value = "/members/image", consumes = {"multipart/form-data"})
    public GenericResponse<ProfileImageInfo> setMemberProfile(@RequestAttribute MemberDetails loginMember, @ModelAttribute MemberProfileImageUpdate profile) throws ImageHostException {
        log.debug("🌠 원본사진 주소 : " + profile.getProfileImage());
        ProfileImageInfo profileImageInfo = profileUpload.uploadMemberProfileImage(profile.getProfileImage());
        profileImageInfo.owned(loginMember.getId());

        memberService.updateProfileImage(loginMember.getId(), profileImageInfo.getUploadUrl());
        return GenericResponse.send("Member update profile image Successfully", profileImageInfo);
    }

    @Operation(
            summary = "사용자 지역 변경",
            tags = "Members",
            description = "사용자는 내 동네 설정을 할 수 있다."
    )
    @PutMapping("/members/region")
    public GenericResponse<Boolean> setMemberRegion(@RequestBody MemberRegion memberRegion) throws NotValidRegionException, NoMainRegionException {
        //region id 적합 확인
        Map<Region, Boolean> basedRegions = BasedRegion.mapping(validRegions.getRegions(memberRegion.getRegionsId()), memberRegion.getRegions());

        memberService.updateRegions(memberRegion.getId(), basedRegions);

        return GenericResponse.send("Member update profile image Successfully", true);
    }

    @Operation(
            summary = "사용자 지역 스위치",
            tags = "Members",
            description = "사용자는 내 동네 전환을 할 수 있다."
    )
    @PatchMapping("/members/region")
    public GenericResponse<Boolean> switchMemberRegion(@RequestBody MemberRegion memberRegion) {
        //TODO: 지역 검증은 추후에 validator 로 검증
        memberService.switchRegions(memberRegion.getId(), memberRegion);

        return GenericResponse.send("Member update profile image Successfully", true);
    }

}
