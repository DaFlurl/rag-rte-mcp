// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_castle_building_DestrctChoiceWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.castle.building.DestrctChoiceWin;
    import mx.core.IFlexModuleFactory;

    public class _view_castle_building_DestrctChoiceWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            DestrctChoiceWin.watcherSetupUtil = new (_view_castle_building_DestrctChoiceWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
        }


    }
}//package 

