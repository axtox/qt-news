using System;
using core_qt.ViewModel;
using Qml.Net;
using Qml.Net.Runtimes;

namespace core_qt
{
    class Program
    {
        static int Main(string[] args)
        {
            RuntimeManager.DiscoverOrDownloadSuitableQtRuntime();

            QQuickStyle.SetStyle("Material");

            using (var app = new QGuiApplication(args))
            {
                using (var engine = new QQmlApplicationEngine())
                {
                    // Register our new type to be used in Qml
                    Qml.Net.Qml.RegisterType<MainViewModel>("Main");

                    engine.Load("View/MainView.qml");
                    
                    return app.Exec();
                }
            }
        }
    }
}
