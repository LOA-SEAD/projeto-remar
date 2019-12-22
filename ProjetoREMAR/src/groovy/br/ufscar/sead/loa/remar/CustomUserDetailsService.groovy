package br.ufscar.sead.loa.remar

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.userdetails.GrailsUser
import grails.plugin.springsecurity.userdetails.GrailsUserDetailsService
import grails.plugin.springsecurity.userdetails.NoStackUsernameNotFoundException
import grails.transaction.Transactional
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UsernameNotFoundException

/**
 * Created by marcus on 19/09/16.
 */
class CustomUserDetailsService implements GrailsUserDetailsService {

    static final List NO_ROLES = [new SimpleGrantedAuthority(SpringSecurityUtils.NO_ROLE)]

    UserDetails loadUserByUsername(String username, boolean loadRoles)
            throws UsernameNotFoundException {
        return loadUserByUsername(username)
    }

    @Transactional(readOnly = true, noRollbackFor = [IllegalArgumentException, UsernameNotFoundException])
    UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        User user = User.findByUsername(username)
        if (!user) throw new NoStackUsernameNotFoundException()

        def roles = user.authorities

        // or if you are using role groups:
        // def roles = user.authorities.collect { it.authorities }.flatten().unique()

        def authorities = roles.collect {
            new SimpleGrantedAuthority(it.authority)
        }

        return new GrailsUser(user.username, user.password, user.enabled, !user.accountExpired,
                !user.passwordExpired, !user.accountLocked,
                authorities ?: NO_ROLES, user.id)
    }

}
