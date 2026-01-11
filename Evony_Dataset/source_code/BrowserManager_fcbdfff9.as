// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.BrowserManager

package mx.managers
{
    import mx.core.Singleton;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BrowserManager 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var implClassDependency:BrowserManagerImpl;
        private static var instance:IBrowserManager;


        public static function getInstance():IBrowserManager
        {
            if (!instance)
            {
                instance = IBrowserManager(Singleton.getInstance("mx.managers::IBrowserManager"));
            };
            return (instance);
        }


    }
}//package mx.managers

