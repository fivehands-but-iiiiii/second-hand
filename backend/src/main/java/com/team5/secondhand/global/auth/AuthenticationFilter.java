package com.team5.secondhand.global.auth;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.team5.secondhand.application.member.dto.response.MemberDetails;
import com.team5.secondhand.global.properties.JwtProperties;
import com.team5.secondhand.global.jwt.util.JwtUtils;
import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
public class AuthenticationFilter extends OncePerRequestFilter {

    private final JwtProperties jwtProperties;
    private final ObjectMapper objectMapper;
    private final JwtUtils jwtUtils;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        String headValue = request.getHeader(jwtProperties.getAuthorizationHeader());

        MemberDetails loginMember = MemberDetails.empty();
        if (headValue != null && headValue.startsWith(jwtProperties.getTokenType())) {
            String token = getToken(headValue);
            Claims claim = jwtUtils.getClaim(token);
            loginMember = objectMapper.readValue((String) claim.get(jwtProperties.getClaimKey()), MemberDetails.class);
        }
        request.setAttribute("loginMember", loginMember);

        chain.doFilter(request, response);
    }

    private String getToken(String headValue) {
        return headValue.split(" ")[1];
    }

}
