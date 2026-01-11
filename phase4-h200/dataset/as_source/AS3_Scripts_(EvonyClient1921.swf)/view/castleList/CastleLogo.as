// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.CastleLogo

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.effects.Parallel;
    import com.evony.common.beans.CastleBean;
    import mx.effects.Glow;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.events.FlexEvent;
    import mx.events.PropertyChangeEvent;
    import view.MainWin;
    import com.evony.events.CurCastleChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.filters.GlowFilter;
    import com.evony.common.constants.ColonyConstants;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import flash.events.TimerEvent;
    import com.evony.Context;
    import flash.geom.Point;
    import flash.display.Bitmap;
    import flash.events.Event;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.colony.ColonialCastlesRespone;
    import com.evony.client.action.ActionFactory;
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

    public class CastleLogo extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1494871014myPhoto:Image;
        private var _839230333markPic:Image;
        private var isFirst:Boolean = true;
        private var _1963141581myOutEffect:Parallel;
        private var _113836232castleBean:CastleBean;
        private var _1777414718glowImageOver:Glow;
        private var isNormal:Boolean = true;
        public var _CastleLogo_Label1:Label;
        private var _1858451296glowImageOut:Glow;
        public var _parent:AllCastleFrame;
        private var _1484556990markPicPath:String = null;
        private var _1725544017myOverEffect:Parallel;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":61,
                    "height":36,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"myPhoto",
                        "events":{"complete":"__myPhoto_complete"},
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":36,
                                "width":60
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_CastleLogo_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "styleName":"castleLogo"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"markPic",
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                            this.top = "2";
                        }
                    })]
                });
            }
        });
        private var castleTooltip:CastleTooltip = CastleTooltip.getInstance();
        private var allColonyArr:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CastleLogo()
        {
            mx_internal::_document = this;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.width = 61;
            this.height = 36;
            _CastleLogo_Parallel2_i();
            _CastleLogo_Parallel1_i();
            this.addEventListener("creationComplete", ___CastleLogo_Canvas1_creationComplete);
            this.addEventListener("click", ___CastleLogo_Canvas1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleLogo._watcherSetupUtil = _arg_1;
        }


        public function ___CastleLogo_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set castleBean(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._113836232castleBean;
            if (_local_2 !== _arg_1)
            {
                this._113836232castleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleBean", _local_2, _arg_1));
            };
        }

        public function set glowImageOver(_arg_1:Glow):void
        {
            var _local_2:Object = this._1777414718glowImageOver;
            if (_local_2 !== _arg_1)
            {
                this._1777414718glowImageOver = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "glowImageOver", _local_2, _arg_1));
            };
        }

        private function set markPicPath(_arg_1:String):void
        {
            var _local_2:Object = this._1484556990markPicPath;
            if (_local_2 !== _arg_1)
            {
                this._1484556990markPicPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "markPicPath", _local_2, _arg_1));
            };
        }

        private function click():void
        {
            if (MainWin.instance.skip_btn.visible == false)
            {
                this.dispatchEvent(new CurCastleChangeEvent(castleBean));
            };
        }

        [Bindable(event="propertyChange")]
        public function get myPhoto():Image
        {
            return (this._1494871014myPhoto);
        }

        private function _CastleLogo_Glow2_i():Glow
        {
            var _local_1:Glow = new Glow();
            glowImageOut = _local_1;
            _local_1.duration = 100;
            _local_1.alphaFrom = 1;
            _local_1.alphaTo = 1;
            _local_1.blurXFrom = 0;
            _local_1.blurXTo = 0;
            _local_1.blurYFrom = 0;
            _local_1.blurYTo = 0;
            _local_1.color = 16639114;
            return (_local_1);
        }

        private function _CastleLogo_Parallel1_i():Parallel
        {
            var _local_1:Parallel = new Parallel();
            myOverEffect = _local_1;
            _local_1.children = [_CastleLogo_Glow1_i()];
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:CastleLogo;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastleLogo_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_CastleLogoWatcherSetupUtil");
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

        [Bindable(event="propertyChange")]
        public function get glowImageOut():Glow
        {
            return (this._1858451296glowImageOut);
        }

        private function _CastleLogo_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return ((this.castleBean.logUrl == null) ? "images/icon/cityLogo/citylogo_01.png" : this.castleBean.logUrl);
            }, function (_arg_1:Object):void
            {
                myPhoto.source = _arg_1;
            }, "myPhoto.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.castleBean.name.substr(0, 3);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleLogo_Label1.text = _arg_1;
            }, "_CastleLogo_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():Array
            {
                return ([new GlowFilter(0xFFFFFF, 1, 4, 4, 8, 1, false, false)]);
            }, function (_arg_1:Array):void
            {
                _CastleLogo_Label1.filters = _arg_1;
            }, "_CastleLogo_Label1.filters");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (markPicPath);
            }, function (_arg_1:Object):void
            {
                markPic.source = _arg_1;
            }, "markPic.source");
            result[3] = binding;
            binding = new Binding(this, function ():Number
            {
                return ((this.castleBean.colonization == ColonyConstants.CASTLE_COLONIZATION_COLONY) ? 32 : 16);
            }, function (_arg_1:Number):void
            {
                markPic.height = _arg_1;
            }, "markPic.height");
            result[4] = binding;
            return (result);
        }

        public function set myOverEffect(_arg_1:Parallel):void
        {
            var _local_2:Object = this._1725544017myOverEffect;
            if (_local_2 !== _arg_1)
            {
                this._1725544017myOverEffect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myOverEffect", _local_2, _arg_1));
            };
        }

        public function ___CastleLogo_Canvas1_click(_arg_1:MouseEvent):void
        {
            click();
        }

        private function logoOverHandle(_arg_1:MouseEvent):void
        {
            if (this.castleTooltip != null)
            {
                PopUpManager.removePopUp(this._parent.colonyList);
                if (!this.castleTooltip.isPopUp)
                {
                    PopUpManager.addPopUp(this.castleTooltip, MainFrame.instance);
                }
                else
                {
                    PopUpManager.bringToFront(this.castleTooltip);
                };
            };
            this.castleTooltip.setCastleBean(this.castleBean);
            if ((((!(this._parent.colonyList == null)) && (!(this.isNormal))) && (!(this.castleBean.colonyBeansArray.length == 0))))
            {
                if (isFirst)
                {
                    isFirst = false;
                    getColonyArr(_arg_1.currentTarget.parent.x, _arg_1.currentTarget.parent.y);
                }
                else
                {
                    if (this.allColonyArr.length == 0)
                    {
                        getColonyArr(_arg_1.currentTarget.parent.x, _arg_1.currentTarget.parent.y);
                    }
                    else
                    {
                        setColonyList(_arg_1.currentTarget.parent.x, _arg_1.currentTarget.parent.y);
                    };
                };
                this._parent.closeListTimer.stop();
                this._parent.closeListTimer.removeEventListener(TimerEvent.TIMER, closeColonyList);
            };
        }

        private function logoOutHandle(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this.castleTooltip);
            if (((!(this.isNormal)) || (!(this.castleBean.colonyBeansArray.length == 0))))
            {
                this._parent.closeListTimer.addEventListener(TimerEvent.TIMER, closeColonyList);
                this._parent.closeListTimer.start();
            };
            if (((Context.getInstance().facebookUser) && (!(Context.getInstance().bVisitor))))
            {
                MainWin.instance.fbBar.visible = true;
            };
        }

        private function playMyEffect():void
        {
            if (this.castleBean != null)
            {
                if (this.castleBean.id == Context.getInstance().getCurCastle().id)
                {
                    this.myOverEffect.play([this.myPhoto]);
                }
                else
                {
                    this.myOutEffect.play([this.myPhoto]);
                };
            };
        }

        private function setColonyList(_arg_1:Number, _arg_2:Number):void
        {
            if (!this._parent.colonyList.isPopUp)
            {
                if (Context.getInstance().facebookUser)
                {
                };
                PopUpManager.addPopUp(this._parent.colonyList, MainFrame.instance);
            }
            else
            {
                PopUpManager.bringToFront(this._parent.colonyList);
            };
            var _local_3:Point = new Point(_arg_1, _arg_2);
            _local_3 = MainWin.instance.allCityList.localToGlobal(_local_3);
            this._parent.colonyList.x = (_local_3.x - 83);
            this._parent.colonyList.y = (_local_3.y + 19);
            this._parent.colonyList.setParent(this);
            trace(("殖民地列表长度：" + this.allColonyArr.length));
            this._parent.colonyList.setCastleBean(this.castleBean, this.allColonyArr);
        }

        private function init():void
        {
            this.mouseChildren = false;
            this.addEventListener(MouseEvent.ROLL_OVER, logoOverHandle);
            this.addEventListener(MouseEvent.ROLL_OUT, logoOutHandle);
            this.addEventListener(MouseEvent.MOUSE_MOVE, logoMoveHandle);
            this.addEventListener(Context.EVENT_CASTLE_CHANGE, this._parent.onCurCastleChangeEvent);
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                Bitmap(_arg_1.currentTarget.content).smoothing = true;
                playMyEffect();
            };
        }

        public function set glowImageOut(_arg_1:Glow):void
        {
            var _local_2:Object = this._1858451296glowImageOut;
            if (_local_2 !== _arg_1)
            {
                this._1858451296glowImageOut = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "glowImageOut", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get glowImageOver():Glow
        {
            return (this._1777414718glowImageOver);
        }

        private function _CastleLogo_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.castleBean.logUrl == null) ? "images/icon/cityLogo/citylogo_01.png" : this.castleBean.logUrl);
            _local_1 = this.castleBean.name.substr(0, 3);
            _local_1 = [new GlowFilter(0xFFFFFF, 1, 4, 4, 8, 1, false, false)];
            _local_1 = markPicPath;
            _local_1 = ((this.castleBean.colonization == ColonyConstants.CASTLE_COLONIZATION_COLONY) ? 32 : 16);
        }

        private function CheckColonyState(_arg_1:ArrayCollection):Boolean
        {
            var _local_7:int;
            isNormal = true;
            var _local_2:Boolean = true;
            var _local_3:ArrayCollection = new ArrayCollection();
            var _local_4:int = _arg_1.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                if (_arg_1[_local_5].status != ColonyConstants.COLONY_STATUS_ATTACKING)
                {
                    _local_3.addItem(_arg_1[_local_5]);
                };
                _local_5++;
            };
            var _local_6:int = _local_3.length;
            if (_local_6 != 0)
            {
                isNormal = false;
                _local_7 = 0;
                while (_local_7 < _local_6)
                {
                    if (_local_3[_local_7].relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED)
                    {
                        _local_2 = false;
                        break;
                    };
                    _local_7++;
                };
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        public function get myOutEffect():Parallel
        {
            return (this._1963141581myOutEffect);
        }

        private function setState():void
        {
            isNormal = true;
            allColonyArr = new ArrayCollection();
            var _local_1:Boolean = CheckColonyState(this.castleBean.colonyBeansArray);
            if (((this.castleBean.colonyBeansArray.length == 0) || (isNormal)))
            {
                markPicPath = null;
            }
            else
            {
                if (_local_1)
                {
                    markPicPath = "images/icon/cityLogo/marklogo_01.png";
                }
                else
                {
                    markPicPath = "images/icon/cityLogo/marklogo_02.png";
                };
            };
        }

        public function closeColonyList(_arg_1:TimerEvent):void
        {
            PopUpManager.removePopUp(this._parent.colonyList);
            if (Context.getInstance().facebookUser)
            {
                MainWin.instance.fbBar.visible = true;
            };
        }

        private function getColonyArr(targetX:Number, targetY:Number):void
        {
            var setColonyArr:Function;
            setColonyArr = function (_arg_1:ColonialCastlesRespone):void
            {
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    allColonyArr = _arg_1.colonyBeansArray;
                    setColonyList(targetX, targetY);
                };
            };
            ActionFactory.getInstance().getColonyCommands().getColonialCastlesInfo(this.castleBean.id, setColonyArr);
        }

        public function __myPhoto_complete(_arg_1:Event):void
        {
            onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get castleBean():CastleBean
        {
            return (this._113836232castleBean);
        }

        public function set setParent(_arg_1:AllCastleFrame):void
        {
            this._parent = _arg_1;
        }

        public function refresh():void
        {
            this.isFirst = true;
            setState();
        }

        private function _CastleLogo_Parallel2_i():Parallel
        {
            var _local_1:Parallel = new Parallel();
            myOutEffect = _local_1;
            _local_1.children = [_CastleLogo_Glow2_i()];
            return (_local_1);
        }

        public function onCurCastleChangeEvent():void
        {
            playMyEffect();
        }

        private function _CastleLogo_Glow1_i():Glow
        {
            var _local_1:Glow = new Glow();
            glowImageOver = _local_1;
            _local_1.duration = 100;
            _local_1.alphaFrom = 1;
            _local_1.alphaTo = 1;
            _local_1.blurXFrom = 0;
            _local_1.blurXTo = 3;
            _local_1.blurYFrom = 0;
            _local_1.blurYTo = 3;
            _local_1.color = 0xFF0000;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get markPicPath():String
        {
            return (this._1484556990markPicPath);
        }

        public function set myOutEffect(_arg_1:Parallel):void
        {
            var _local_2:Object = this._1963141581myOutEffect;
            if (_local_2 !== _arg_1)
            {
                this._1963141581myOutEffect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myOutEffect", _local_2, _arg_1));
            };
        }

        public function set myPhoto(_arg_1:Image):void
        {
            var _local_2:Object = this._1494871014myPhoto;
            if (_local_2 !== _arg_1)
            {
                this._1494871014myPhoto = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myPhoto", _local_2, _arg_1));
            };
        }

        public function set markPic(_arg_1:Image):void
        {
            var _local_2:Object = this._839230333markPic;
            if (_local_2 !== _arg_1)
            {
                this._839230333markPic = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "markPic", _local_2, _arg_1));
            };
        }

        public function set setCastle(_arg_1:CastleBean):void
        {
            this.castleBean = _arg_1;
            setState();
        }

        private function logoMoveHandle(_arg_1:MouseEvent):void
        {
            this.castleTooltip.moveToMouse(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get markPic():Image
        {
            return (this._839230333markPic);
        }

        [Bindable(event="propertyChange")]
        public function get myOverEffect():Parallel
        {
            return (this._1725544017myOverEffect);
        }


    }
}//package view.castleList

