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
    appInstance : IWebApplication;

begin

    (*!-----------------------------------------------
     * Bootstrap Fast CGI application
     *
     * @author AUTHOR_NAME <author@email.tld>
     *------------------------------------------------*)
    appInstance := TDaemonWebApplication.create(
        TFastCgiAppServiceProvider.create(
            TServerAppServiceProvider.create(
                TAppServiceProvider.create(),
                (TBoundSvrFactory.create(stdInputHandle) as ISocketSvrFactory).build()
            )
        ),
        TAppRoutes.create()
    );
    appInstance.run();
end.