// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IFlexModuleFactory

package mx.core
{
    import flash.utils.Dictionary;

    public interface IFlexModuleFactory 
    {

        function get preloadedRSLs():Dictionary;
        function allowInsecureDomain(... _args):void;
        function create(... _args):Object;
        function allowDomain(... _args):void;
        function info():Object;

    }
}//package mx.core

