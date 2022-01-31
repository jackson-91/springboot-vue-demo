package org.dev.common.security.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.security.access.SecurityConfig;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;

@Component
@ConfigurationProperties(prefix="springbootvue")
public class PermitAllConfig {
    private Collection<String> permitAll = new ArrayList<>();
    private Collection<SecurityConfig> authorize = new ArrayList<>();

    public Collection<String> getPermitAll() {
        return permitAll;
    }

    public Collection<SecurityConfig> getAuthorize() {
        return authorize;
    }
}
