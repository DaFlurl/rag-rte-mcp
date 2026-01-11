// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IEmbeddedFontRegistry

package mx.core
{
    public interface IEmbeddedFontRegistry 
    {

        function getAssociatedModuleFactory(_arg_1:EmbeddedFont, _arg_2:IFlexModuleFactory):IFlexModuleFactory;
        function registerFont(_arg_1:EmbeddedFont, _arg_2:IFlexModuleFactory):void;
        function deregisterFont(_arg_1:EmbeddedFont, _arg_2:IFlexModuleFactory):void;
        function getFonts():Array;

    }
}//package mx.core

