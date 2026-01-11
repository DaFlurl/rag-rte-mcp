// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.world.Tile

package view.castle.world
{
    import mx.core.UIComponent;
    import com.evony.util.EvonyAnimation;
    import com.evony.common.beans.MapCastleBean;
    import flash.geom.Point;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.constants.FieldConstants;
    import com.evony.util.ResourceLoader;
    import com.evony.Lang;

    public class Tile extends UIComponent 
    {

        public var level:int = 0;
        private var castleFlag:CastleFlag;
        private var myHostMc:EvonyAnimation;
        private var _223702571_fieldType:int;
        public var a:EvonyAnimation = null;
        private var _432176964mapCastleBean:MapCastleBean;
        private var isX:int = 10;
        private var isHost:Boolean = false;
        public var address:Point = null;
        private var isY:int = -32;
        private var iMcCount:int = 0;
        public var powerLevel:int = 0;

        public function Tile()
        {
            this.mouseChildren = false;
            this.cacheAsBitmap = true;
            var _local_1:int;
            while (_local_1 < this.numChildren)
            {
                this.removeChildAt(_local_1);
                _local_1++;
            };
        }

        public function stop():void
        {
            if (this.a != null)
            {
                this.a.stop();
            };
        }

        public function addCastleFlag():void
        {
            if (((!(this.mapCastleBean == null)) && (this.castleFlag == null)))
            {
                this.castleFlag = new CastleFlag();
                this.addChild(castleFlag);
                this.castleFlag.setMapCastleBean(this.mapCastleBean, this.level);
            };
        }

        public function setSecondMap(_arg_1:MapCastleBean, _arg_2:Boolean=false):void
        {
            this.mapCastleBean = _arg_1;
            removeCastleFlag();
        }

        public function getFieldName():String
        {
            if (isCastle())
            {
                if (this.mapCastleBean != null)
                {
                    return (mapCastleBean.name);
                };
                return ("Loading...");
            };
            return (getFieldName_sub(this._fieldType, this.level, this.powerLevel));
        }

        public function setFirstMap(_arg_1:String, _arg_2:Boolean, _arg_3:Point, _arg_4:int, _arg_5:int):void
        {
            var _local_6:int = parseInt(_arg_1.charAt(0), 16);
            var _local_7:int = parseInt(_arg_1.charAt(1), 16);
            this.isHost = _arg_2;
            this.address = _arg_3;
            if ((((!(_local_6 == this._fieldType)) || (!(_local_7 == this.level))) || (!(this.powerLevel == _arg_4))))
            {
                this._fieldType = _local_6;
                this.level = (_local_7 + ((4 - _arg_4) * 2));
                if (this.level >= 14)
                {
                    trace("this.level>=14");
                };
                this.powerLevel = _arg_4;
                removeAnimation();
                this.mapCastleBean = null;
            };
            removeMyHostFlags();
            removeCastleFlag();
        }

        public function addMyHostFlags():void
        {
            if (((this.isHost) && (this.myHostMc == null)))
            {
                myHostMc = new EvonyAnimation();
                myHostMc.load(EvonyAnimation.TYPE_MyHost, -1);
                myHostMc.x = 45;
                myHostMc.y = 20;
                this.addChild(myHostMc);
            };
        }

        public function set mapCastleBean(_arg_1:MapCastleBean):void
        {
            var _local_2:Object = this._432176964mapCastleBean;
            if (_local_2 !== _arg_1)
            {
                this._432176964mapCastleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mapCastleBean", _local_2, _arg_1));
            };
        }

        public function removeCastleFlag():void
        {
            if (((!(this.castleFlag == null)) && (this.contains(this.castleFlag))))
            {
                this.removeChild(this.castleFlag);
                this.castleFlag.destroy();
                this.castleFlag = null;
            };
        }

        public function setTilexy(_arg_1:int, _arg_2:int):void
        {
        }

        public function play():void
        {
            if (this.a != null)
            {
                this.a.play();
            };
        }

        public function set _fieldType(_arg_1:int):void
        {
            var _local_2:Object = this._223702571_fieldType;
            if (_local_2 !== _arg_1)
            {
                this._223702571_fieldType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_fieldType", _local_2, _arg_1));
            };
        }

        public function getAddress():Point
        {
            return (this.address);
        }

        [Bindable(event="propertyChange")]
        public function get mapCastleBean():MapCastleBean
        {
            return (this._432176964mapCastleBean);
        }

        public function isCastle():Boolean
        {
            return ((fieldType == FieldConstants.TYPE_CASTLE) || (fieldType == FieldConstants.TYPE_NPC));
        }

        public function getLevel():int
        {
            return (this.level);
        }

        public function removeMyHostFlags():void
        {
            if (myHostMc != null)
            {
                if (this.contains(this.myHostMc))
                {
                    this.removeChild(myHostMc);
                };
                myHostMc.destroy();
                myHostMc = null;
            };
        }

        [Bindable(event="propertyChange")]
        public function get _fieldType():int
        {
            return (this._223702571_fieldType);
        }

        public function get fieldType():int
        {
            return (this._fieldType);
        }

        public function addAnimation():void
        {
            var _local_1:int;
            if (this.a == null)
            {
                _local_1 = EvonyAnimation.getAniIdFromFieldType(this._fieldType, this.level, this.powerLevel);
                if (this.mapCastleBean != null)
                {
                    if (this.mapCastleBean.changeface != 0)
                    {
                        _local_1 = 265;
                    };
                };
                a = new EvonyAnimation();
                a.load(_local_1, -1, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
                this.addChild(a);
            };
        }

        public function removeAnimation():void
        {
            if (((!(this.a == null)) && (this.contains(this.a))))
            {
                this.removeChild(this.a);
                this.a.destroy();
                this.a = null;
            };
        }

        public function getIsHost():Boolean
        {
            return (this.isHost);
        }

        public function getFieldName_sub(_arg_1:int, _arg_2:int, _arg_3:int):String
        {
            var _local_4:* = "";
            var _local_5:* = "";
            switch (_arg_1)
            {
                case FieldConstants.TYPE_DESERT:
                    _local_4 = Lang.msg("荒漠");
                    _local_5 = Lang.msg("石料产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_DESERT_RATE) + FieldConstants.PRODUCE_DESERT_BASE));
                    break;
                case FieldConstants.TYPE_FLAT:
                    _local_4 = Lang.msg("平地");
                    _local_5 = Lang.msg("可以筑城");
                    break;
                case FieldConstants.TYPE_FOREST:
                    _local_4 = Lang.msg("森林");
                    _local_5 = Lang.msg("木材产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_FOREST_RATE) + FieldConstants.PRODUCE_FOREST_BASE));
                    break;
                case FieldConstants.TYPE_GRASSLAND:
                    _local_4 = Lang.msg("草原");
                    _local_5 = Lang.msg("粮食产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_GRASSLAND_RATE) + FieldConstants.PRODUCE_GRASSLAND_BASE));
                    break;
                case FieldConstants.TYPE_HILL:
                    _local_4 = Lang.msg("山地");
                    _local_5 = Lang.msg("铁矿产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_HILL_RATE) + FieldConstants.PRODUCE_HILL_BASE));
                    break;
                case FieldConstants.TYPE_LAKE:
                    _local_4 = Lang.msg("湖泊");
                    _local_5 = Lang.msg("粮食产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_LAKE_RATE) + FieldConstants.PRODUCE_LAKE_BASE));
                    break;
                case FieldConstants.TYPE_SWAMP:
                    _local_4 = Lang.msg("沼泽");
                    _local_5 = Lang.msg("粮食产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_SWAP_RATE) + FieldConstants.PRODUCE_SWAP_BASE));
                    break;
            };
            return (_local_4);
        }

        public function getFieldDesc():String
        {
            return (getFieldDesc_sub(this._fieldType, this.level, this.powerLevel));
        }

        public function getCastleFlag():CastleFlag
        {
            return (this.castleFlag);
        }

        public function getPowerLevel():int
        {
            return (this.powerLevel);
        }

        public function getFieldDesc_sub(_arg_1:int, _arg_2:int, _arg_3:int):String
        {
            var _local_4:* = "";
            var _local_5:* = "";
            switch (_arg_1)
            {
                case FieldConstants.TYPE_DESERT:
                    _local_4 = Lang.msg("荒漠");
                    _local_5 = Lang.msg("石料产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_DESERT_RATE) + FieldConstants.PRODUCE_DESERT_BASE));
                    break;
                case FieldConstants.TYPE_FLAT:
                    _local_4 = Lang.msg("平地");
                    _local_5 = Lang.msg("可以筑城");
                    break;
                case FieldConstants.TYPE_FOREST:
                    _local_4 = Lang.msg("森林");
                    _local_5 = Lang.msg("木材产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_FOREST_RATE) + FieldConstants.PRODUCE_FOREST_BASE));
                    break;
                case FieldConstants.TYPE_GRASSLAND:
                    _local_4 = Lang.msg("草原");
                    _local_5 = Lang.msg("粮食产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_GRASSLAND_RATE) + FieldConstants.PRODUCE_GRASSLAND_BASE));
                    break;
                case FieldConstants.TYPE_HILL:
                    _local_4 = Lang.msg("山地");
                    _local_5 = Lang.msg("铁矿产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_HILL_RATE) + FieldConstants.PRODUCE_HILL_BASE));
                    break;
                case FieldConstants.TYPE_LAKE:
                    _local_4 = Lang.msg("湖泊");
                    _local_5 = Lang.msg("粮食产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_LAKE_RATE) + FieldConstants.PRODUCE_LAKE_BASE));
                    break;
                case FieldConstants.TYPE_SWAMP:
                    _local_4 = Lang.msg("沼泽");
                    _local_5 = Lang.msg("粮食产量增加{0}%", ((_arg_2 * FieldConstants.PRODUCE_SWAP_RATE) + FieldConstants.PRODUCE_SWAP_BASE));
                    break;
            };
            return (_local_5);
        }


    }
}//package view.castle.world

