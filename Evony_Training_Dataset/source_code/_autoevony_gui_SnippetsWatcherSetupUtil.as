// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_SnippetsWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.Snippets;
    import mx.core.IFlexModuleFactory;

    public class _autoevony_gui_SnippetsWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Snippets.watcherSetupUtil = new (_autoevony_gui_SnippetsWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
        }


    }
}//package 

