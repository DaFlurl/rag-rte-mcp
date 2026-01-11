// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_CityPanelWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.CityPanel;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_CityPanelWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            CityPanel.watcherSetupUtil = new (_autoevony_gui_CityPanelWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[35] = new PropertyWatcher("troopsData", {"propertyChange":true}, [_arg_3[45]], _arg_2);
            _arg_4[37] = new PropertyWatcher("fortificationsData", {"propertyChange":true}, [_arg_3[47]], _arg_2);
            _arg_4[34] = new PropertyWatcher("armyData", {"propertyChange":true}, [_arg_3[42]], _arg_2);
            _arg_4[26] = new PropertyWatcher("resourceData", {"propertyChange":true}, [_arg_3[27]], _arg_2);
            _arg_4[39] = new PropertyWatcher("externalTroopData", {"propertyChange":true}, [_arg_3[49]], _arg_2);
            _arg_4[1] = new PropertyWatcher("_cityPanelBean", {"propertyChange":true}, [_arg_3[1], _arg_3[9], _arg_3[10], _arg_3[11]], _arg_2);
            _arg_4[2] = new PropertyWatcher("goalsTxt", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[3] = new PropertyWatcher("scriptTxt", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[4] = new PropertyWatcher("scriptIsRunning", {"propertyChange":true}, [_arg_3[10], _arg_3[11]], null);
            _arg_4[31] = new PropertyWatcher("buildingData", {"propertyChange":true}, [_arg_3[38]], _arg_2);
            _arg_4[36] = new PropertyWatcher("troopQueueData", {"propertyChange":true}, [_arg_3[46]], _arg_2);
            _arg_4[27] = new PropertyWatcher("valleyData", {"propertyChange":true}, [_arg_3[28]], _arg_2);
            _arg_4[32] = new PropertyWatcher("researchData", {"propertyChange":true}, [_arg_3[39]], _arg_2);
            _arg_4[38] = new PropertyWatcher("tradesData", {"propertyChange":true}, [_arg_3[48]], _arg_2);
            _arg_4[30] = new PropertyWatcher("heroData", {"propertyChange":true}, [_arg_3[34]], _arg_2);
            _arg_4[8] = new PropertyWatcher("_inputNewCastleName", {"propertyChange":true}, [_arg_3[15]], _arg_2);
            _arg_4[9] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[15]], null);
            _arg_4[33] = new PropertyWatcher("gearsData", {"propertyChange":true}, [_arg_3[40]], _arg_2);
            _arg_4[28] = new PropertyWatcher("colonyData", {"propertyChange":true}, [_arg_3[30]], _arg_2);
            _arg_4[29] = new PropertyWatcher("innHeroData", {"propertyChange":true}, [_arg_3[32]], _arg_2);
            _arg_4[0] = new PropertyWatcher("_castleBean", {"propertyChange":true}, [_arg_3[0], _arg_3[2], _arg_3[3], _arg_3[4], _arg_3[5], _arg_3[6], _arg_3[7], _arg_3[8], _arg_3[12], _arg_3[13], _arg_3[14], _arg_3[17], _arg_3[16], _arg_3[19], _arg_3[18], _arg_3[21], _arg_3[20], _arg_3[23], _arg_3[22], _arg_3[25], _arg_3[24], _arg_3[26]], _arg_2);
            _arg_4[7] = new PropertyWatcher("powerlevel", {"propertyChange":true}, [_arg_3[13], _arg_3[14]], null);
            _arg_4[5] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[11] = new PropertyWatcher("resource", {"propertyChange":true}, [_arg_3[17], _arg_3[16], _arg_3[19], _arg_3[18], _arg_3[21], _arg_3[20], _arg_3[23], _arg_3[25], _arg_3[24]], null);
            _arg_4[24] = new PropertyWatcher("workPeople", {"propertyChange":true}, [_arg_3[25], _arg_3[24]], null);
            _arg_4[12] = new PropertyWatcher("support", {"propertyChange":true}, [_arg_3[17], _arg_3[16]], null);
            _arg_4[22] = new PropertyWatcher("curPopulation", {"propertyChange":true}, [_arg_3[23], _arg_3[25], _arg_3[24]], null);
            _arg_4[16] = new PropertyWatcher("texRate", {"propertyChange":true}, [_arg_3[21], _arg_3[20]], null);
            _arg_4[14] = new PropertyWatcher("complaint", {"propertyChange":true}, [_arg_3[19], _arg_3[18]], null);
            _arg_4[19] = new PropertyWatcher("fieldId", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[35].updateParent(_arg_1);
            _arg_4[37].updateParent(_arg_1);
            _arg_4[34].updateParent(_arg_1);
            _arg_4[26].updateParent(_arg_1);
            _arg_4[39].updateParent(_arg_1);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[1].addChild(_arg_4[2]);
            _arg_4[1].addChild(_arg_4[3]);
            _arg_4[1].addChild(_arg_4[4]);
            _arg_4[31].updateParent(_arg_1);
            _arg_4[36].updateParent(_arg_1);
            _arg_4[27].updateParent(_arg_1);
            _arg_4[32].updateParent(_arg_1);
            _arg_4[38].updateParent(_arg_1);
            _arg_4[30].updateParent(_arg_1);
            _arg_4[8].updateParent(_arg_1);
            _arg_4[8].addChild(_arg_4[9]);
            _arg_4[33].updateParent(_arg_1);
            _arg_4[28].updateParent(_arg_1);
            _arg_4[29].updateParent(_arg_1);
            _arg_4[0].updateParent(_arg_1);
            _arg_4[0].addChild(_arg_4[7]);
            _arg_4[0].addChild(_arg_4[5]);
            _arg_4[0].addChild(_arg_4[11]);
            _arg_4[11].addChild(_arg_4[24]);
            _arg_4[11].addChild(_arg_4[12]);
            _arg_4[11].addChild(_arg_4[22]);
            _arg_4[11].addChild(_arg_4[16]);
            _arg_4[11].addChild(_arg_4[14]);
            _arg_4[0].addChild(_arg_4[19]);
        }


    }
}//package 

