(*!------------------------------------------------------------
 * [[APP_NAME]] ([[APP_URL]])
 *
 * @link      [[APP_REPOSITORY_URL]]
 * @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
 * @license   [[LICENSE_URL]] ([[LICENSE]])
 *------------------------------------------------------------- *)
program app;

uses

    fano,
    bootstrap;

var
    appInstance, fcgiApp, cgiApp : IWebApplication;

begin

    (*!-----------------------------------------------
     * Bootstrap CGI Fast CGI gateway application
     *
     * @author AUTHOR_NAME <author@email.tld>
     *------------------------------------------------*)
    fcgiApp := TDaemonWebApplication.create(
        TFastCgiAppServiceProvider.create(
            TServerAppServiceProvider.create(
                TAppServiceProvider.create(),
                (TBoundSvrFactory.create(stdInputHandle) as ISocketSvrFactory).build()
            )
        ),
        TAppRoutes.create()
    );

    cgiApp := TCgiWebApplication.create(
        TAppServiceProvider.create(),
        TAppRoutes.create()
    );

    appInstance := TCgiFcgiGatewayApplication.create(cgiApp, fcgiApp);
    appInstance.run();
end.
