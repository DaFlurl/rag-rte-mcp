// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.resources.ResourceManager

package mx.resources
{
    import mx.core.mx_internal;
    import mx.core.Singleton;

    use namespace mx_internal;

    public class ResourceManager 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var implClassDependency:ResourceManagerImpl;
        private static var instance:IResourceManager;


        public static function getInstance():IResourceManager
        {
            if (!instance)
            {
                try
                {
                    instance = IResourceManager(Singleton.getInstance("mx.resources::IResourceManager"));
                }
                catch(e:Error)
                {
                    instance = new ResourceManagerImpl();
                };
            };
            return (instance);
        }


    }
}//package mx.resources

