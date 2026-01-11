// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.world.FieldImageMc

package view.castle.world
{
    import com.evony.util.EvonyAnimation;
    import com.evony.Lang;
    import com.evony.common.constants.FieldConstants;

    public class FieldImageMc extends EvonyAnimation 
    {

        private var fieldName:String;
        private var fieldDesc:String;

        public function FieldImageMc()
        {
            this.load(EvonyAnimation.TYPE_FieldImageMc, -1);
        }

        public function setFieldType(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:String;
            var _local_5:int;
            switch (_arg_1)
            {
                case FieldConstants.TYPE_DESERT:
                    this.fieldName = Lang.msg("荒漠");
                    this.fieldDesc = Lang.msg("石料产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_DESERT_RATE) + FieldConstants.PRODUCE_DESERT_BASE));
                    _local_4 = ("desert_" + getFrameNameByLevel(_arg_2));
                    break;
                case FieldConstants.TYPE_FLAT:
                    this.fieldName = Lang.msg("平地");
                    this.fieldDesc = Lang.msg("可以筑城");
                    _local_4 = "flat";
                    break;
                case FieldConstants.TYPE_FOREST:
                    this.fieldName = Lang.msg("森林");
                    this.fieldDesc = Lang.msg("木材产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_FOREST_RATE) + FieldConstants.PRODUCE_FOREST_BASE));
                    _local_4 = ("forest_" + getFrameNameByLevel(_arg_2));
                    break;
                case FieldConstants.TYPE_GRASSLAND:
                    this.fieldName = Lang.msg("草原");
                    this.fieldDesc = Lang.msg("粮食产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_GRASSLAND_RATE) + FieldConstants.PRODUCE_GRASSLAND_BASE));
                    _local_4 = ("grass_" + getFrameNameByLevel(_arg_2));
                    break;
                case FieldConstants.TYPE_HILL:
                    this.fieldName = Lang.msg("山地");
                    this.fieldDesc = Lang.msg("铁矿产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_HILL_RATE) + FieldConstants.PRODUCE_HILL_BASE));
                    _local_4 = ("hill_" + getFrameNameByLevel(_arg_2));
                    break;
                case FieldConstants.TYPE_LAKE:
                    this.fieldName = Lang.msg("湖泊");
                    this.fieldDesc = Lang.msg("粮食产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_LAKE_RATE) + FieldConstants.PRODUCE_LAKE_BASE));
                    _local_4 = ("lake_" + getFrameNameByLevel(_arg_2));
                    break;
                case FieldConstants.TYPE_SWAMP:
                    this.fieldName = Lang.msg("沼泽");
                    this.fieldDesc = Lang.msg("粮食产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_SWAP_RATE) + FieldConstants.PRODUCE_SWAP_BASE));
                    _local_4 = ("swamp_" + getFrameNameByLevel(_arg_2));
                    break;
                default:
                    _local_5 = 0;
                    if (_arg_3 < 4)
                    {
                        if (_arg_3 == 0)
                        {
                            _local_4 = "npc_h";
                        }
                        else
                        {
                            if (_arg_3 == 1)
                            {
                                _local_4 = "npc_s";
                            }
                            else
                            {
                                if (_arg_3 == 2)
                                {
                                    _local_4 = "npc_m";
                                }
                                else
                                {
                                    if (_arg_3 == 3)
                                    {
                                        _local_4 = "npc_l";
                                    };
                                };
                            };
                        };
                    }
                    else
                    {
                        if (_arg_2 == 10)
                        {
                            if (_local_5 <= 5)
                            {
                                _local_4 = "castle_h";
                            }
                            else
                            {
                                _local_4 = "castle2_h";
                            };
                        }
                        else
                        {
                            if (_local_5 <= 5)
                            {
                                _local_4 = ("castle_" + getFrameNameByLevel(_arg_2));
                            }
                            else
                            {
                                _local_4 = ("castle2_" + getFrameNameByLevel(_arg_2));
                            };
                        };
                    };
            };
            this.gotoAndStopNative(_local_4);
        }

        public function getFieldDesc():String
        {
            return (this.fieldDesc);
        }

        private function getFrameNameByLevel(_arg_1:int):String
        {
            if (_arg_1 < 4)
            {
                return ("s");
            };
            if (_arg_1 < 7)
            {
                return ("m");
            };
            return ("l");
        }

        public function getFieldName():String
        {
            return (this.fieldName);
        }


    }
}//package view.castle.world

