// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.styles.IStyleManager2

package mx.styles
{
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;
    import flash.events.IEventDispatcher;

    public interface IStyleManager2 extends IStyleManager 
    {

        function get selectors():Array;
        function loadStyleDeclarations2(_arg_1:String, _arg_2:Boolean=true, _arg_3:ApplicationDomain=null, _arg_4:SecurityDomain=null):IEventDispatcher;

    }
}//package mx.styles

