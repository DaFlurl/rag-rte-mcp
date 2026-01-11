// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.PLayerBuffBar

package view.castle
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.collections.ArrayCollection;
    import mx.controls.HorizontalList;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.beans.BuffBean;
    import com.evony.factory.BuffManager;
    import com.evony.Context;
    import com.evony.util.UIUtil;
    import mx.events.FlexEvent;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.server.events.CastleBuffUpdate;
    import mx.core.ClassFactory;
    import com.evony.MsgDispacther;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.Event;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class PLayerBuffBar extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2032248903buffsArray:ArrayCollection;
        public var _PLayerBuffBar_HorizontalList1:HorizontalList;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "right";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HorizontalList,
                                    "id":"_PLayerBuffBar_HorizontalList1",
                                    "stylesFactory":function ():void
                                    {
                                        this.backgroundAlpha = 0;
                                        this.borderStyle = "none";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "selectable":false,
                                            "percentHeight":100,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "itemRenderer":_PLayerBuffBar_ClassFactory1_c()
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PLayerBuffBar()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.borderStyle = "none";
                this.cornerRadius = 0;
            };
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___PLayerBuffBar_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PLayerBuffBar._watcherSetupUtil = _arg_1;
        }


        public function set buffsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2032248903buffsArray;
            if (_local_2 !== _arg_1)
            {
                this._2032248903buffsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buffsArray", _local_2, _arg_1));
            };
        }

        private function unionBuff(_arg_1:String):void
        {
            var _local_5:BuffBean;
            var _local_2:BuffBean;
            var _local_3:int;
            while (_local_3 < buffsArray.length)
            {
                _local_5 = BuffBean(buffsArray[_local_3]);
                if (_local_5.typeId.indexOf(_arg_1) == 0)
                {
                    if (_local_2 == null)
                    {
                        _local_2 = new BuffBean(buffsArray[_local_3]);
                        _local_2.typeId = _arg_1;
                    }
                    else
                    {
                        if (_local_5.endTime > _local_2.endTime)
                        {
                            _local_2.endTime = _local_5.endTime;
                            _local_2.descName = _local_5.descName;
                        };
                    };
                };
                _local_3++;
            };
            var _local_4:int;
            while (_local_4 < buffsArray.length)
            {
                _local_5 = BuffBean(buffsArray[_local_4]);
                if (_local_5.typeId.indexOf(_arg_1) == 0)
                {
                    buffsArray.removeItemAt(_local_4);
                    _local_4--;
                };
                _local_4++;
            };
            if (_local_2 != null)
            {
                buffsArray.addItem(_local_2);
            };
        }

        public function refreshBuff():void
        {
            var _local_2:BuffBean;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            buffsArray = BuffManager.buffFilter(Context.getInstance().getPlayerBean().buffsArray);
            if (!Context.getInstance().needUserGuide)
            {
                if (UIUtil.judgeTime() < 3)
                {
                    _local_2 = new BuffBean();
                    _local_2.typeId = "doubleBuilding";
                    _local_2.descName = "Can build two buildings at one time.";
                    _local_3 = new Date().valueOf();
                    _local_4 = Context.getInstance().getPlayerBean().playerInfo.createrTime;
                    _local_5 = Context.getInstance().getTimeDiff();
                    _local_2.endTime = (((((3 * 24) * 3600) * 1000) + _local_4) - _local_5);
                    buffsArray.addItem(_local_2);
                }
                else
                {
                    buffsArray = BuffManager.buffFilter(Context.getInstance().getPlayerBean().buffsArray);
                };
            };
            var _local_1:int;
            while (_local_1 < buffsArray.length)
            {
                if (BuffBean(buffsArray[_local_1]).typeId == "TopeVotesPrivilegeBuf")
                {
                    Context.getInstance().bVictor = true;
                    break;
                };
                _local_1++;
            };
            addCastleBuff();
            unionBuff("ReduceArmyActionBuff");
            unionBuff("ArmyStaminaBuff");
            unionBuff("IncAllHeroPropertyBuff");
            unionBuff("IncArmyActionTimeBuff");
            unionBuff("ReduceallheropropertyBuff");
        }

        private function _PLayerBuffBar_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.buffsArray;
            _local_1 = this.buffsArray.length;
        }

        public function ___PLayerBuffBar_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function castlebuffRefresh(_arg_1:CastleBuffUpdate):void
        {
            var _local_3:CastleBean;
            var _local_4:Boolean;
            var _local_5:int;
            var _local_6:BuffBean;
            var _local_2:int;
            while (_local_2 < Context.getInstance().getPlayerBean().castlesArray.length)
            {
                _local_3 = Context.getInstance().getPlayerBean().getCastles(_local_2);
                if (_local_3.id == _arg_1.castleid)
                {
                    _local_4 = false;
                    _local_5 = 0;
                    while (_local_5 < _local_3.buffsArray.length)
                    {
                        _local_6 = BuffBean(_local_3.buffsArray[_local_5]);
                        if (_local_6.typeId == _arg_1.buffBean.typeId)
                        {
                            _local_4 = true;
                            if (_arg_1.updateType == 1)
                            {
                                _local_3.buffsArray.removeItemAt(_local_5);
                            }
                            else
                            {
                                if (_arg_1.updateType == 0)
                                {
                                    _local_3.buffsArray.addItem(_arg_1.buffBean);
                                }
                                else
                                {
                                    _local_6.typeId = _arg_1.buffBean.typeId;
                                    _local_6.descName = _arg_1.buffBean.descName;
                                    _local_6.endTime = _arg_1.buffBean.endTime;
                                };
                            };
                        };
                        _local_5++;
                    };
                    if (_local_4 == false)
                    {
                        if (((_arg_1.updateType == 0) || (_arg_1.updateType == 2)))
                        {
                            _local_3.buffsArray.addItem(_arg_1.buffBean);
                        };
                    };
                };
                _local_2++;
            };
            refreshBuff();
            TownView.singleton().refreshWall();
        }

        private function _PLayerBuffBar_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PLayerBuffBar_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function init():void
        {
            BuffManager.sortBuffArray(Context.getInstance().getPlayerBean().buffsArray);
            refreshBuff();
            MsgDispacther.getInstance().addEventListener(Context.EVENT_PLAYER_LOGIN, onPlayerLogin);
            MsgDispacther.getInstance().addEventListener("refreshBuff", buffUpdata);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_CASTLE_BUFF_UPDATE, castlebuffRefresh);
        }

        private function onPlayerLogin(_arg_1:Event):void
        {
            var _local_2:BuffBean;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            buffsArray = Context.getInstance().getPlayerBean().buffsArray;
            if (!Context.getInstance().needUserGuide)
            {
                if (UIUtil.judgeTime() < 3)
                {
                    _local_2 = new BuffBean();
                    _local_2.typeId = "doubleBuilding";
                    _local_2.descName = "Can build two buildings at one time.";
                    _local_3 = new Date(Context.getInstance().serverYear, (Context.getInstance().serverMonth - 1), Context.getInstance().serverDate, Context.getInstance().serverHours, Context.getInstance().serverMinutes, 0).valueOf();
                    _local_4 = Context.getInstance().getPlayerBean().playerInfo.createrTime;
                    _local_5 = Context.getInstance().getTimeDiff();
                    _local_2.endTime = (((((3 * 24) * 3600) * 1000) + _local_4) - _local_5);
                    buffsArray.addItem(_local_2);
                };
            };
        }

        private function addCastleBuff():void
        {
            var _local_1:BuffBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buffsArray)
            {
                if (((((((!(_local_1.typeId.indexOf("IncArmyActionTimeBuff") == -1)) || (!(_local_1.typeId.indexOf("ReduceallheropropertyBuff") == -1))) || (!(_local_1.typeId.indexOf("KillAllPeopleBuff") == -1))) || (!(_local_1.typeId.indexOf("ForceopenclosegateBuff") == -1))) || (!(_local_1.typeId.indexOf("ForceopenclosegateBuffCooldownBuff") == -1))) || (!(_local_1.typeId.indexOf("HauntedCastleBuf") == -1))))
                {
                    this.buffsArray.addItem(_local_1);
                };
            };
        }

        private function _PLayerBuffBar_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.buffsArray);
            }, function (_arg_1:Object):void
            {
                _PLayerBuffBar_HorizontalList1.dataProvider = _arg_1;
            }, "_PLayerBuffBar_HorizontalList1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.buffsArray.length);
            }, function (_arg_1:int):void
            {
                _PLayerBuffBar_HorizontalList1.columnCount = _arg_1;
            }, "_PLayerBuffBar_HorizontalList1.columnCount");
            result[1] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:PLayerBuffBar;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PLayerBuffBar_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_PLayerBuffBarWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        public function sortBuffsArray():void
        {
        }

        private function buffUpdata(_arg_1:Event):void
        {
            refreshBuff();
            TownView.singleton().refreshWall();
        }

        [Bindable(event="propertyChange")]
        public function get buffsArray():ArrayCollection
        {
            return (this._2032248903buffsArray);
        }


    }
}//package view.castle

