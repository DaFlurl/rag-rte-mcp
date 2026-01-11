// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.building.BuildingLevelUC

package view.castle.building
{
    import mx.core.UIComponent;
    import mx.binding.utils.ChangeWatcher;
    import flash.display.MovieClip;
    import mx.binding.utils.BindingUtils;
    import com.evony.MsgDispacther;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.common.beans.BuildingBean;

    public class BuildingLevelUC extends UIComponent 
    {

        private var watchers:ChangeWatcher;
        private var bgMC:MovieClip;
        private var numMC:MovieClip;

        public function BuildingLevelUC()
        {
            this.width = 22.9;
            this.height = 30.5;
            var _local_1:Class = BuildingLevelUC_buildingBgClass;
            this.bgMC = (new (_local_1)() as MovieClip);
            this.bgMC.stop();
            var _local_2:Class = BuildingLevelUC_buildingNumClass;
            this.numMC = (new (_local_2)() as MovieClip);
            this.numMC.stop();
            this.numMC.x = 3;
            this.numMC.y = 2;
            this.addChild(this.bgMC);
            this.addChild(this.numMC);
            BindingUtils.bindProperty(this, "visible", MsgDispacther.getInstance(), "showBuildingLevel");
        }

        public function set onBuildingLevelChange(_arg_1:int):void
        {
            this.numMC.gotoAndStop((_arg_1 + 1));
        }

        public function set buildingBean(_arg_1:BuildingBean):void
        {
            if (_arg_1 != null)
            {
                this.bgMC.alpha = 1;
                if (this.watchers != null)
                {
                    this.watchers.unwatch();
                };
                this.watchers = BindingUtils.bindProperty(this, "onBuildingLevelChange", _arg_1, "level");
                switch (_arg_1.typeId)
                {
                    case BuildingConstants.TYPE_BARRACK:
                        this.bgMC.gotoAndStop("Barrack");
                        break;
                    case BuildingConstants.TYPE_MARKET:
                        this.bgMC.gotoAndStop("Market");
                        break;
                    case BuildingConstants.TYPE_TAVERN:
                        this.bgMC.gotoAndStop("Tavern");
                        break;
                    case BuildingConstants.TYPE_TRAINNING_FEILD:
                        this.bgMC.gotoAndStop("TrainningField");
                        break;
                    case BuildingConstants.TYPE_HEROS_MANSION:
                        this.bgMC.gotoAndStop("Tavern");
                        break;
                    default:
                        if (_arg_1.level > 5)
                        {
                            this.bgMC.gotoAndStop("level1");
                        }
                        else
                        {
                            this.bgMC.gotoAndStop("level2");
                        };
                };
            }
            else
            {
                this.bgMC.alpha = 0;
                this.bgMC.gotoAndStop("level1");
                this.numMC.gotoAndStop(1);
            };
        }


    }
}//package view.castle.building

