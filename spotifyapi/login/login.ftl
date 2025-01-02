<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <!-- ${msg("loginAccountTitle")}-->
        
        <!--/opt/keycloak/bin/kc.sh build-->
    <#elseif section = "form">
    <div class="loginWrapper">
    <div class='loginFormHeading'>You've been invited to collaborate to</div>
        <div id="kc-form">
          <div id="kc-form-wrapper">
          

          <div class='loginWrapperMain'>
            <div class='loginPgImgHelper'>
                <img src='${url.resourcesPath}/img/playlistCover.png' class='loginPgImage' alt='Playlist Preview Image'>
            </div>
            <div class='inviteMainTxt'>Schulball '25</div>
            <div class='mainLoginField'>
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                    
                         <#if messagesPerField.existsError('username','password')>
                                    <!--invalid login message-->
                                    <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                            ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                    </span>
                                </#if>

                        <!--USERNAME-->
                        <#if !usernameHidden??>
                            <div class="${properties.kcFormGroupClass!}">
                                <!--<label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>-->

                                <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" placeholder="Moodle Username" autofocus autocomplete="off"
                                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />

                            </div>
                        </#if>

                        <!--PASSWORD-->
                        <div class="${properties.kcFormGroupClass!}">
                            <div class="${properties.kcInputGroup!}">
                                <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password" placeholder="Moodle Password" type="password" autocomplete="off"
                                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                />

                                <!--SHOW PASSWORD BTN-->
                                <!--
                                <button class="${properties.kcFormPasswordVisibilityButtonClass!}" type="button" aria-label="${msg("showPassword")}"
                                        aria-controls="password"  data-password-toggle
                                        data-icon-show="${properties.kcFormPasswordVisibilityIconShow!}" data-icon-hide="${properties.kcFormPasswordVisibilityIconHide!}"
                                        data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}">
                                    <i class="${properties.kcFormPasswordVisibilityIconShow!}" aria-hidden="true"></i>
                                </button> -->
                            </div>

                            <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                                <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                            </#if>

                        </div>

                        <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                            <div id="kc-form-options">
                                <#if realm.rememberMe && !usernameHidden??>
                                    <div class="checkbox">
                                        <label>
                                            <#if login.rememberMe??>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                            <#else>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                            </#if>
                                        </label>
                                    </div>
                                </#if>
                                </div>
                                <div class="${properties.kcFormOptionsWrapperClass!}">
                                    <#if realm.resetPasswordAllowed>
                                        <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                                    </#if>
                                </div>

                        </div>


                        <!--LOGIN BUTTON-->
                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="Log In"/><!--value="${msg("doLogIn")}"-->
                        </div>
                    </form>
                    </#if>
                </div>
                <div class='loginMainWidgetDiff'>
                    <img src='${url.resourcesPath}/img/loginPageDiff.svg' class="imgDivider" width=300/>
                </div>
                <a href='https://schulball.ohgw.de/playlist?pl=1DWeZYfgG7OZlyUFUiDai4&v=1' class='loginViewPlTxt'>view playlist</a>
            </div>
        </div>
        </div>
        <div class="btmTxt">log in with your moodle credentials</div>        
        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
        </div>
        <div class="addLegalInfo">Copyright © 2024 Nicolas Pfeifer. <span class="breakHelper">All rights reserved. </span><br/>
 This site is licensed under the <a href="https://github.com/nicode3141/spotifyAPI-keycloak-theme/blob/main/LICENSE" class="legalMITLink">MIT License.</a></div>
    <#elseif section = "info" >

       

        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <li>
                            <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                    type="button" href="${p.loginUrl}">
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                </#if>
                            </a>
                        </li>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>


</@layout.registrationLayout>