// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.utils.SecurityUtil

package mx.utils
{
    import mx.core.mx_internal;
    import mx.core.ISWFBridgeProvider;

    use namespace mx_internal;

    public class SecurityUtil 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        public static function hasMutualTrustBetweenParentAndChild(_arg_1:ISWFBridgeProvider):Boolean
        {
            if ((((_arg_1) && (_arg_1.childAllowsParent)) && (_arg_1.parentAllowsChild)))
            {
                return (true);
            };
            return (false);
        }


    }
}//package mx.utils

