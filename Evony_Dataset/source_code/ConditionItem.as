// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.util.ConditionItem

package com.evony.util
{
    import flash.events.IEventDispatcher;
    import mx.binding.utils.ChangeWatcher;
    import flash.events.EventDispatcher;
    import com.evony.Lang;
    import mx.binding.utils.BindingUtils;
    import com.evony.Context;
    import com.evony.eum.ItemEumDefine;
    import com.evony.eum.ItemEum;
    import com.evony.common.beans.ConditionDependItemBean;
    import com.evony.eum.TechEumDefine;
    import com.evony.eum.TechEum;
    import com.evony.common.beans.ConditionDependTechBean;
    import com.evony.common.beans.ItemBean;
    import com.evony.common.beans.BuildingBean;
    import com.evony.eum.BuildingEumDefine;
    import com.evony.common.beans.ConditionDependBuildingBean;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;

    public class ConditionItem implements IEventDispatcher 
    {

        public static const MATCH_FONT_COLOR:String = "tabContent3";
        public static const NO_MATCH_FONT_COLOR:String = "tabContent2";
        private static var woodItem:ConditionItem = null;
        private static var foodItem:ConditionItem = null;
        private static var ironItem:ConditionItem = null;
        private static var stoneItem:ConditionItem = null;
        private static var goldItem:ConditionItem = null;

        private var watcher:ChangeWatcher;
        private var _1095692943request:String;
        private var _1805110236styleName:String;
        private var _3373707name:String;
        private var resReq:Number;
        private var _94842723color:String;
        private var conditionType:String = "";
        private var _1126940025current:*;
        private var _bindingEventDispatcher:EventDispatcher;

        public function ConditionItem()
        {
            _bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
            super();
        }

        public static function iron(_arg_1:int):ConditionItem
        {
            var _local_2:ConditionItem;
            if (ironItem == null)
            {
                _local_2 = new (ConditionItem)();
                _local_2.name = Lang.msg("铁矿");
                ironItem = _local_2;
            };
            ironItem.setWatch(BindingUtils.bindProperty(ironItem, "resAmount", Context.getInstance().getCurCastle().resource.iron, "amount"));
            ironItem.setResourceRequest(_arg_1);
            return (ironItem);
        }

        public static function population(_arg_1:int):ConditionItem
        {
            var _local_2:ConditionItem = new (ConditionItem)();
            _local_2.name = Lang.msg("人口");
            _local_2.request = String(_arg_1);
            _local_2.current = Context.getInstance().getCurCastle().resource.curPopulation;
            return (_local_2);
        }

        public static function item(_arg_1:ConditionDependItemBean):ConditionItem
        {
            var _local_2:ConditionItem = new (ConditionItem)();
            var _local_3:* = "Unknow";
            var _local_4:ItemEum = ItemEumDefine.getItemEum(_arg_1.id);
            if (_local_2 != null)
            {
                _local_3 = _local_4.name;
            };
            _local_2.name = Lang.msg("宝物");
            _local_2.request = (((_local_3 + "(") + _arg_1.num) + ")");
            _local_2.current = _arg_1.curNum;
            if (!_arg_1.successFlag)
            {
                _local_2.styleName = MATCH_FONT_COLOR;
            }
            else
            {
                _local_2.styleName = NO_MATCH_FONT_COLOR;
            };
            return (_local_2);
        }

        public static function tech(_arg_1:ConditionDependTechBean):ConditionItem
        {
            var _local_2:ConditionItem = new (ConditionItem)();
            var _local_3:* = "";
            var _local_4:TechEum = TechEumDefine.getTechEumByType(_arg_1.id);
            if (_local_2 != null)
            {
                _local_3 = _local_4.name;
            };
            _local_2.name = Lang.msg("科技");
            _local_2.request = ((((_local_3 + "(") + Lang.msg("等级（简）")) + _arg_1.level) + ")");
            _local_2.current = (Lang.msg("等级（简）") + _arg_1.curLevel);
            if (!_arg_1.successFlag)
            {
                _local_2.styleName = MATCH_FONT_COLOR;
            }
            else
            {
                _local_2.styleName = NO_MATCH_FONT_COLOR;
            };
            return (_local_2);
        }

        public static function equipTechItem(_arg_1:Object):ConditionItem
        {
            var _local_3:ItemBean;
            var _local_2:ConditionItem = new (ConditionItem)();
            _local_2.name = _arg_1.name;
            _local_2.request = _arg_1.num;
            _local_2.current = 0;
            for each (_local_3 in Context.getInstance().getPlayerBean().itemsArray)
            {
                if (_local_3.id == _arg_1.id)
                {
                    _local_2.current = _local_3.count;
                };
            };
            if (_local_2.current >= int(_local_2.request))
            {
                _local_2.styleName = NO_MATCH_FONT_COLOR;
            }
            else
            {
                _local_2.styleName = MATCH_FONT_COLOR;
            };
            return (_local_2);
        }

        public static function food(_arg_1:int):ConditionItem
        {
            var _local_2:ConditionItem;
            if (foodItem == null)
            {
                _local_2 = new (ConditionItem)();
                _local_2.name = Lang.msg("粮食");
                foodItem = _local_2;
            };
            foodItem.setWatch(BindingUtils.bindProperty(foodItem, "resAmount", Context.getInstance().getCurCastle().resource.food, "amount"));
            foodItem.setResourceRequest(_arg_1);
            return (foodItem);
        }

        public static function stone(_arg_1:int):ConditionItem
        {
            var _local_2:ConditionItem;
            if (stoneItem == null)
            {
                _local_2 = new (ConditionItem)();
                _local_2.name = Lang.msg("石料");
                _local_2.setResourceRequest(_arg_1);
                stoneItem = _local_2;
            };
            stoneItem.setWatch(BindingUtils.bindProperty(stoneItem, "resAmount", Context.getInstance().getCurCastle().resource.stone, "amount"));
            stoneItem.setResourceRequest(_arg_1);
            return (stoneItem);
        }

        public static function gold(_arg_1:int):ConditionItem
        {
            var _local_2:ConditionItem;
            if (goldItem == null)
            {
                _local_2 = new (ConditionItem)();
                _local_2.name = Lang.msg("黄金");
                goldItem = _local_2;
            };
            goldItem.resAmount = Context.getInstance().getCurCastle().resource.gold;
            goldItem.setResourceRequest(_arg_1);
            return (goldItem);
        }

        public static function equipTechBuild(_arg_1:Object):ConditionItem
        {
            var _local_4:BuildingBean;
            var _local_2:int;
            var _local_3:ConditionItem = new (ConditionItem)();
            _local_3.name = Lang.msg("建筑");
            _local_3.request = ((((_arg_1.name + "(") + Lang.msg("等级（简）")) + _arg_1.lev) + ")");
            for each (_local_4 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (((_local_4.typeId == _arg_1.typeId) && (_local_4.level > _local_2)))
                {
                    _local_2 = _local_4.level;
                };
            };
            _local_3.current = (Lang.msg("等级（简）") + _local_2);
            if (_local_2 >= int(_arg_1.lev))
            {
                _local_3.styleName = NO_MATCH_FONT_COLOR;
            }
            else
            {
                _local_3.styleName = MATCH_FONT_COLOR;
            };
            return (_local_3);
        }

        public static function wood(_arg_1:int):ConditionItem
        {
            var _local_2:ConditionItem;
            if (woodItem == null)
            {
                _local_2 = new (ConditionItem)();
                _local_2.name = Lang.msg("木材");
                woodItem = _local_2;
            };
            woodItem.setWatch(BindingUtils.bindProperty(woodItem, "resAmount", Context.getInstance().getCurCastle().resource.wood, "amount"));
            woodItem.setResourceRequest(_arg_1);
            return (woodItem);
        }

        public static function building(_arg_1:ConditionDependBuildingBean):ConditionItem
        {
            var _local_2:ConditionItem = new (ConditionItem)();
            _local_2.name = Lang.msg("建筑");
            _local_2.request = ((((BuildingEumDefine.getName(_arg_1.typeId) + "(") + Lang.msg("等级（简）")) + _arg_1.level) + ")");
            _local_2.current = (Lang.msg("等级（简）") + _arg_1.curLevel);
            if (!_arg_1.successFlag)
            {
                _local_2.styleName = MATCH_FONT_COLOR;
            }
            else
            {
                _local_2.styleName = NO_MATCH_FONT_COLOR;
            };
            return (_local_2);
        }

        public static function equipTechTreasure(_arg_1:Object):ConditionItem
        {
            var _local_3:ItemBean;
            var _local_2:ConditionItem = new (ConditionItem)();
            _local_2.name = Lang.msg("宝物");
            _local_2.request = (((_arg_1.name + "(") + _arg_1.num) + ")");
            _local_2.current = 0;
            for each (_local_3 in Context.getInstance().getPlayerBean().itemsArray)
            {
                if (_local_3.id == _arg_1.id)
                {
                    _local_2.current = _local_3.count;
                };
            };
            if (_local_2.current >= int(_arg_1.num))
            {
                _local_2.styleName = NO_MATCH_FONT_COLOR;
            }
            else
            {
                _local_2.styleName = MATCH_FONT_COLOR;
            };
            return (_local_2);
        }


        public function dispatchEvent(_arg_1:Event):Boolean
        {
            return (_bindingEventDispatcher.dispatchEvent(_arg_1));
        }

        public function set current(_arg_1:*):void
        {
            var _local_2:Object = this._1126940025current;
            if (_local_2 !== _arg_1)
            {
                this._1126940025current = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "current", _local_2, _arg_1));
            };
        }

        public function set color(_arg_1:String):void
        {
            var _local_2:Object = this._94842723color;
            if (_local_2 !== _arg_1)
            {
                this._94842723color = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "color", _local_2, _arg_1));
            };
        }

        public function set styleName(_arg_1:String):void
        {
            var _local_2:Object = this._1805110236styleName;
            if (_local_2 !== _arg_1)
            {
                this._1805110236styleName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "styleName", _local_2, _arg_1));
            };
        }

        public function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void
        {
            _bindingEventDispatcher.removeEventListener(_arg_1, _arg_2, _arg_3);
        }

        [Bindable(event="propertyChange")]
        public function get name():String
        {
            return (this._3373707name);
        }

        private function setWatch(_arg_1:ChangeWatcher):void
        {
            if (this.watcher != null)
            {
                this.watcher.unwatch();
            };
            this.watcher = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get request():String
        {
            return (this._1095692943request);
        }

        public function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            _bindingEventDispatcher.addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public function set name(_arg_1:String):void
        {
            var _local_2:Object = this._3373707name;
            if (_local_2 !== _arg_1)
            {
                this._3373707name = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "name", _local_2, _arg_1));
            };
        }

        public function set request(_arg_1:String):void
        {
            var _local_2:Object = this._1095692943request;
            if (_local_2 !== _arg_1)
            {
                this._1095692943request = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "request", _local_2, _arg_1));
            };
        }

        private function setResourceRequest(_arg_1:int):void
        {
            this.request = String(_arg_1);
            this.resReq = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get styleName():String
        {
            return (this._1805110236styleName);
        }

        public function willTrigger(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.willTrigger(_arg_1));
        }

        [Bindable(event="propertyChange")]
        public function get color():String
        {
            return (this._94842723color);
        }

        public function hasEventListener(_arg_1:String):Boolean
        {
            return (_bindingEventDispatcher.hasEventListener(_arg_1));
        }

        public function set resAmount(_arg_1:Number):void
        {
            _arg_1 = Math.floor(_arg_1);
            this.current = _arg_1;
            if (this.resReq > _arg_1)
            {
                this.styleName = MATCH_FONT_COLOR;
            }
            else
            {
                this.styleName = NO_MATCH_FONT_COLOR;
            };
        }

        [Bindable(event="propertyChange")]
        public function get current():*
        {
            return (this._1126940025current);
        }

        public function setConditionType(_arg_1:String):void
        {
            conditionType = _arg_1;
        }


    }
}//package com.evony.util

