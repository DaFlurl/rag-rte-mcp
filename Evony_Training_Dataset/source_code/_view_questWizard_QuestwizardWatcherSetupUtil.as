// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_questWizard_QuestwizardWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.questWizard.Questwizard;
    import mx.core.IFlexModuleFactory;

    public class _view_questWizard_QuestwizardWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            Questwizard.watcherSetupUtil = new (_view_questWizard_QuestwizardWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
        }


    }
}//package 

