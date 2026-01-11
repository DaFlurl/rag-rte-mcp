// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.AllCastleFrame

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.List;
    import view.ui.CastleBuildTip;
    import mx.collections.ArrayCollection;
    import mx.core.UIComponentDescriptor;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.MsgDispacther;
    import com.evony.Context;
    import com.evony.events.BuildnewCastleEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import flash.display.DisplayObjectContainer;
    import com.evony.client.action.ActionFactory;
    import com.evony.events.WindowChangeEvent;
    import view.MainWin;
    import view.castle.TownView;
    import com.evony.events.CurCastleChangeEvent;
    import com.evony.factory.UIFactory;
    import com.evony.common.beans.ArmyBean;
    import com.evony.common.constants.ArmyConstants;
    import com.evony.common.constants.ObjConstants;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.PlayerBean;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import mx.controls.listClasses.ListBaseContentHolder;
    import mx.core.ClassFactory;
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

    public class AllCastleFrame extends Canvas implements IBindingClient 
    {

        public static const EVENT_REFRESH:String = "AllCastleFrame.refresh";
        public static const CASTLE_LOGO_HEIGHT:int = 38;
        public static var instance:AllCastleFrame = new (AllCastleFrame)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1038347423ConditionBtn:Button;
        private var _114138550castleList:List;
        public var _AllCastleFrame_Button1:Button;
        public var _AllCastleFrame_Button2:Button;
        private var castleIconHeight:int = 36;
        private var cbTip:CastleBuildTip;
        private var _1378835236btnEna:Boolean = true;
        private var castleAry:ArrayCollection;
        private var maxRow:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"_AllCastleFrame_Button1",
                        "events":{"click":"___AllCastleFrame_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"PageUp"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_AllCastleFrame_Button2",
                        "events":{"click":"___AllCastleFrame_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "0";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"PageDown"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"ConditionBtn",
                        "events":{
                            "mouseMove":"__ConditionBtn_mouseMove",
                            "mouseOver":"__ConditionBtn_mouseOver",
                            "mouseOut":"__ConditionBtn_mouseOut"
                        },
                        "stylesFactory":function ():void
                        {
                            this.bottom = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":64,
                                "height":38,
                                "visible":false,
                                "styleName":"castleTipBtn"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "42";
                            this.bottom = "90";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":List,
                                    "id":"castleList",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "0";
                                        this.bottom = "0";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "rowHeight":38,
                                            "columnWidth":66,
                                            "columnCount":1,
                                            "styleName":"friendslist",
                                            "verticalScrollPolicy":"off",
                                            "alpha":1,
                                            "itemRenderer":_AllCastleFrame_ClassFactory1_c()
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var newCastleAry:Array = new Array();
        private var objArray:Array = new Array();
        private var _2126052102itemArray:ArrayCollection = new ArrayCollection();
        private var _1588162706logoArray:ArrayCollection = new ArrayCollection();
        public var closeListTimer:Timer = new Timer(1000, 1);
        public var colonyList:ColonyList = ColonyList.getInstance();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllCastleFrame()
        {
            mx_internal::_document = this;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AllCastleFrame_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllCastleFrame._watcherSetupUtil = _arg_1;
        }


        private function set itemArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2126052102itemArray;
            if (_local_2 !== _arg_1)
            {
                this._2126052102itemArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get itemArray():ArrayCollection
        {
            return (this._2126052102itemArray);
        }

        private function init():void
        {
            MsgDispacther.getInstance().addEventListener(Context.EVENT_CASTLE_CHANGE, onCurCastleChangeEventFromOutSide);
            MsgDispacther.getInstance().addEventListener(EVENT_REFRESH, refresh);
            MsgDispacther.getInstance().addEventListener(BuildnewCastleEvent.EVENT_BUILD_CASTLE, onBuildHandler);
            this.refresh(null);
        }

        private function _AllCastleFrame_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEna);
            }, function (_arg_1:Boolean):void
            {
                _AllCastleFrame_Button1.enabled = _arg_1;
            }, "_AllCastleFrame_Button1.enabled");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEna);
            }, function (_arg_1:Boolean):void
            {
                _AllCastleFrame_Button2.enabled = _arg_1;
            }, "_AllCastleFrame_Button2.enabled");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.itemArray);
            }, function (_arg_1:Object):void
            {
                castleList.dataProvider = _arg_1;
            }, "castleList.dataProvider");
            result[2] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:AllCastleFrame;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllCastleFrame_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_AllCastleFrameWatcherSetupUtil");
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

        public function __ConditionBtn_mouseOver(_arg_1:MouseEvent):void
        {
            overHandler(_arg_1);
        }

        private function _AllCastleFrame_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.btnEna;
            _local_1 = this.btnEna;
            _local_1 = this.itemArray;
        }

        private function outHnadler(_arg_1:MouseEvent):void
        {
            if (this.cbTip != null)
            {
                PopUpManager.removePopUp(this.cbTip);
            };
        }

        private function onCurCastleChangeEventFromOutSide(_arg_1:*):void
        {
            refreshLogo();
        }

        private function refreshLogo():void
        {
            var _local_1:Object = new Object();
            var _local_2:int = (this.castleList.getChildAt(2) as DisplayObjectContainer).numChildren;
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_1 = (this.castleList.getChildAt(2) as DisplayObjectContainer).getChildAt(_local_3);
                if (((!(_local_1 == null)) && (_local_1.getChildAt(0) is CastleLogo)))
                {
                    (_local_1.getChildAt(0) as CastleLogo).onCurCastleChangeEvent();
                };
                _local_3++;
            };
        }

        public function __ConditionBtn_mouseOut(_arg_1:MouseEvent):void
        {
            outHnadler(_arg_1);
        }

        private function clickHandler(_arg_1:String):void
        {
            if (_arg_1 == "up")
            {
                if (castleList.verticalScrollPosition > 0)
                {
                    castleList.verticalScrollPosition--;
                };
            }
            else
            {
                if (_arg_1 == "down")
                {
                    if (maxRow < 10)
                    {
                        if (castleList.verticalScrollPosition < (itemArray.length - maxRow))
                        {
                            castleList.verticalScrollPosition++;
                        };
                    };
                };
            };
        }

        private function moveHandler(_arg_1:MouseEvent):void
        {
            if (this.cbTip != null)
            {
                this.cbTip.moveToMouse(_arg_1);
            };
        }

        public function __ConditionBtn_mouseMove(_arg_1:MouseEvent):void
        {
            moveHandler(_arg_1);
        }

        public function ___AllCastleFrame_Button2_click(_arg_1:MouseEvent):void
        {
            clickHandler("down");
        }

        private function set btnEna(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1378835236btnEna;
            if (_local_2 !== _arg_1)
            {
                this._1378835236btnEna = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnEna", _local_2, _arg_1));
            };
        }

        public function set ConditionBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1038347423ConditionBtn;
            if (_local_2 !== _arg_1)
            {
                this._1038347423ConditionBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ConditionBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get castleList():List
        {
            return (this._114138550castleList);
        }

        public function onCurCastleChangeEvent(_arg_1:CurCastleChangeEvent):void
        {
            ActionFactory.getInstance().getCastleCommands().UpdateCastleResources(Context.getInstance().getCurCastle().id);
            Context.getInstance().setCurCastle(_arg_1.getCastle());
            refreshLogo();
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(WindowChangeEvent.ID_CLOSE));
            MainWin.instance.buff.bar.refreshBuff();
            TownView.singleton().refreshWall();
        }

        private function initHeight():void
        {
            var _local_1:Number = this.castleList.height;
            maxRow = Math.floor((_local_1 / 38));
            if (((maxRow < 10) && (itemArray.length > maxRow)))
            {
                this.btnEna = true;
            };
        }

        private function set logoArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1588162706logoArray;
            if (_local_2 !== _arg_1)
            {
                this._1588162706logoArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logoArray", _local_2, _arg_1));
            };
        }

        private function overHandler(_arg_1:MouseEvent):void
        {
            this.cbTip = UIFactory.getInstance().getCastleBuildTip();
            this.cbTip.moveToMouse(_arg_1);
            if (!this.cbTip.isPopUp)
            {
                PopUpManager.addPopUp(this.cbTip, this);
            }
            else
            {
                PopUpManager.bringToFront(this.cbTip);
            };
            this.cbTip.aryLength = this.castleAry.length;
        }

        private function rangeCastleLogo(_arg_1:ArrayCollection):void
        {
            var _local_3:int;
            var _local_4:CastlePercent;
            this.objArray.splice(0);
            this.newCastleAry.splice(0);
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                if (((ArmyBean(_arg_1[_local_2]).missionType == ObjConstants.ARMY_MISSION_CONSTRUCT) && (ArmyBean(_arg_1[_local_2]).direction == ArmyConstants.ARMY_FORWARD)))
                {
                    this.newCastleAry.push(_arg_1[_local_2]);
                };
                _local_2++;
            };
            if (this.newCastleAry.length > 0)
            {
                _local_3 = 0;
                while (_local_3 < this.newCastleAry.length)
                {
                    _local_4 = new CastlePercent();
                    _local_4.x = 2;
                    _local_4.y = (((this.castleAry.length + _local_3) * AllCastleFrame.CASTLE_LOGO_HEIGHT) + 2);
                    _local_4.bean = this.newCastleAry[_local_3];
                    this.objArray.push(_local_4);
                    this.castleList.addChild(_local_4);
                    _local_3++;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get ConditionBtn():Button
        {
            return (this._1038347423ConditionBtn);
        }

        private function refresh(_arg_1:Event):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:CastleBean;
            if (this.objArray.length > 0)
            {
                _local_3 = 0;
                while (_local_3 < this.objArray.length)
                {
                    this.objArray[_local_3].timerStop();
                    this.castleList.removeChild(this.objArray[_local_3]);
                    _local_3++;
                };
            };
            this.itemArray = new ArrayCollection();
            var _local_2:PlayerBean = Context.getInstance().getPlayerBean();
            this.castleAry = _local_2.castlesArray;
            if (_local_2 != null)
            {
                _local_4 = 2;
                for each (_local_5 in _local_2.castlesArray)
                {
                    itemArray.addItem({
                        "castle":_local_5,
                        "parent":this
                    });
                };
            };
            initHeight();
            if (((!(this.castleAry == null)) && (this.castleAry.length <= 12)))
            {
                this.ConditionBtn.x = 3;
                this.ConditionBtn.visible = true;
            }
            else
            {
                this.ConditionBtn.visible = false;
            };
            if (_local_2.selfArmysArray.length > 0)
            {
                this.rangeCastleLogo(_local_2.selfArmysArray);
            };
            if (_arg_1 != null)
            {
                refreshState();
            };
        }

        [Bindable(event="propertyChange")]
        private function get btnEna():Boolean
        {
            return (this._1378835236btnEna);
        }

        public function ___AllCastleFrame_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get logoArray():ArrayCollection
        {
            return (this._1588162706logoArray);
        }

        public function set castleList(_arg_1:List):void
        {
            var _local_2:Object = this._114138550castleList;
            if (_local_2 !== _arg_1)
            {
                this._114138550castleList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleList", _local_2, _arg_1));
            };
        }

        private function refreshState():void
        {
            var _local_2:DisplayObjectContainer;
            var _local_1:Object = new Object();
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < this.castleList.numChildren)
            {
                if ((this.castleList.getChildAt(_local_3) is ListBaseContentHolder))
                {
                    _local_2 = (this.castleList.getChildAt(_local_3) as DisplayObjectContainer);
                };
                _local_3++;
            };
            var _local_4:int = _local_2.numChildren;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_1 = _local_2.getChildAt(_local_5);
                if ((((!(_local_1 == null)) && (!(_local_1.numChildren == 0))) && (_local_1.getChildAt(0) is CastleLogo)))
                {
                    (_local_1.getChildAt(0) as CastleLogo).refresh();
                };
                _local_5++;
            };
        }

        private function _AllCastleFrame_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllCastleFrame_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function onBuildHandler(_arg_1:BuildnewCastleEvent=null):void
        {
            this.refresh(null);
        }

        public function ___AllCastleFrame_Button1_click(_arg_1:MouseEvent):void
        {
            clickHandler("up");
        }


    }
}//package view.castleList

