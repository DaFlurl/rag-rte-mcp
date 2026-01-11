// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.ColonyList

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.CastleBean;
    import mx.controls.List;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Image;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.beans.ColonyBean;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.managers.PopUpManager;
    import mx.events.FlexEvent;
    import mx.core.ClassFactory;
    import com.evony.common.constants.ColonyConstants;
    import flash.events.TimerEvent;
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

    public class ColonyList extends Canvas implements IBindingClient 
    {

        private static var instance:ColonyList = new (ColonyList)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1294659208isShowSuzerain:Boolean = false;
        private var _1482715966panelList:Canvas;
        private var _1197987000colonyList:Canvas;
        private var _113836232castleBean:CastleBean;
        private var _1378835236btnEna:Boolean = true;
        private var _parent:CastleLogo;
        private var _1978309676colonyNum:int;
        private var _1952007207colonielist:List;
        public var _ColonyList_Button1:Button;
        public var _ColonyList_Button2:Button;
        public var _ColonyList_Canvas2:Canvas;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"_ColonyList_Canvas2",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":10,
                                "y":17,
                                "width":72,
                                "height":46,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.bottom = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"images/colonielistBg.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"colonyList",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "6";
                                        this.top = "7";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":34,
                                            "width":62,
                                            "verticalScrollPolicy":"off",
                                            "horizontalScrollPolicy":"off"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"panelList",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":365,
                                "styleName":"colonielistbg",
                                "y":0,
                                "x":0,
                                "width":85,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_ColonyList_Button1",
                                    "events":{"click":"___ColonyList_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "25";
                                        this.left = "8";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"coloniebutup"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_ColonyList_Button2",
                                    "events":{"click":"___ColonyList_Button2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "25";
                                        this.left = "8";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"coloniebutdown"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":List,
                                    "id":"colonielist",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "52";
                                        this.left = "9";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":70,
                                            "rowHeight":44,
                                            "columnWidth":70,
                                            "columnCount":1,
                                            "rowCount":6,
                                            "styleName":"friendslist",
                                            "verticalScrollPolicy":"off",
                                            "alpha":1,
                                            "height":263,
                                            "itemRenderer":_ColonyList_ClassFactory1_c()
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var colonyArr:ArrayCollection = new ArrayCollection();
        private var SuzerainArr:ArrayCollection = new ArrayCollection();
        private var _2126052102itemArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ColonyList()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___ColonyList_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonyList._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():ColonyList
        {
            return (instance);
        }


        public function ___ColonyList_Button2_click(_arg_1:MouseEvent):void
        {
            clonieListPosition("down");
        }

        public function set panelList(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1482715966panelList;
            if (_local_2 !== _arg_1)
            {
                this._1482715966panelList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "panelList", _local_2, _arg_1));
            };
        }

        public function set itemArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2126052102itemArray;
            if (_local_2 !== _arg_1)
            {
                this._2126052102itemArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isShowSuzerain():Boolean
        {
            return (this._1294659208isShowSuzerain);
        }

        private function showColonyList():void
        {
            var _local_2:ColonyBean;
            var _local_3:ColonyLogo;
            this.colonyList.removeAllChildren();
            var _local_1:int = 2;
            for each (_local_2 in SuzerainArr)
            {
                _local_3 = new ColonyLogo();
                _local_3.LogoColonyBean = _local_2;
                _local_3.LogoCastleBean = castleBean;
                _local_3.Parent = this._parent._parent;
                this.colonyList.addChild(_local_3);
            };
        }

        override public function initialize():void
        {
            var target:ColonyList;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ColonyList_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_ColonyListWatcherSetupUtil");
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

        private function listOutHandle(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this._parent._parent.colonyList);
        }

        [Bindable(event="propertyChange")]
        public function get itemArray():ArrayCollection
        {
            return (this._2126052102itemArray);
        }

        private function init():void
        {
            this.addEventListener(MouseEvent.ROLL_OVER, listOverHandle);
            this.addEventListener(MouseEvent.ROLL_OUT, listOutHandle);
        }

        private function clonieListPosition(_arg_1:String):void
        {
            if (_arg_1 == "up")
            {
                if (colonielist.verticalScrollPosition > 0)
                {
                    colonielist.verticalScrollPosition--;
                };
            }
            else
            {
                if (_arg_1 == "down")
                {
                    if (colonielist.verticalScrollPosition < (colonyArr.length - 6))
                    {
                        colonielist.verticalScrollPosition++;
                    };
                };
            };
        }

        public function ___ColonyList_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get colonyList():Canvas
        {
            return (this._1197987000colonyList);
        }

        private function _ColonyList_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = ColonyList_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
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

        private function set btnEna(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1378835236btnEna;
            if (_local_2 !== _arg_1)
            {
                this._1378835236btnEna = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnEna", _local_2, _arg_1));
            };
        }

        public function set colonielist(_arg_1:List):void
        {
            var _local_2:Object = this._1952007207colonielist;
            if (_local_2 !== _arg_1)
            {
                this._1952007207colonielist = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonielist", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get panelList():Canvas
        {
            return (this._1482715966panelList);
        }

        public function setParent(_arg_1:CastleLogo):void
        {
            this._parent = _arg_1;
        }

        public function ___ColonyList_Button1_click(_arg_1:MouseEvent):void
        {
            clonieListPosition("up");
        }

        [Bindable(event="propertyChange")]
        private function get castleBean():CastleBean
        {
            return (this._113836232castleBean);
        }

        public function setCastleBean(_arg_1:CastleBean, _arg_2:ArrayCollection):void
        {
            this.castleBean = _arg_1;
            this.colonyArr = new ArrayCollection();
            this.SuzerainArr = new ArrayCollection();
            var _local_3:int = _arg_2.length;
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (_arg_2[_local_4].status != ColonyConstants.COLONY_STATUS_ATTACKING)
                {
                    this.colonyArr.addItem(_arg_2[_local_4]);
                };
                _local_4++;
            };
            isShowSuzerain = false;
            var _local_5:int = this.colonyArr.length;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                if (this.colonyArr[_local_6].relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED)
                {
                    isShowSuzerain = true;
                    SuzerainArr.addItem(colonyArr[_local_6]);
                    this.showColonyList();
                    break;
                };
                _local_6++;
            };
            if (!isShowSuzerain)
            {
                loadOk();
            };
        }

        private function _ColonyList_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShowSuzerain);
            }, function (_arg_1:Boolean):void
            {
                _ColonyList_Canvas2.visible = _arg_1;
            }, "_ColonyList_Canvas2.visible");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.isShowSuzerain));
            }, function (_arg_1:Boolean):void
            {
                panelList.visible = _arg_1;
            }, "panelList.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEna);
            }, function (_arg_1:Boolean):void
            {
                _ColonyList_Button1.enabled = _arg_1;
            }, "_ColonyList_Button1.enabled");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEna);
            }, function (_arg_1:Boolean):void
            {
                _ColonyList_Button2.enabled = _arg_1;
            }, "_ColonyList_Button2.enabled");
            result[3] = binding;
            binding = new Binding(this, function ():Object
            {
                return (itemArray);
            }, function (_arg_1:Object):void
            {
                colonielist.dataProvider = _arg_1;
            }, "colonielist.dataProvider");
            result[4] = binding;
            return (result);
        }

        private function set isShowSuzerain(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1294659208isShowSuzerain;
            if (_local_2 !== _arg_1)
            {
                this._1294659208isShowSuzerain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isShowSuzerain", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get colonielist():List
        {
            return (this._1952007207colonielist);
        }

        private function listOverHandle(_arg_1:MouseEvent):void
        {
            this._parent._parent.closeListTimer.stop();
            this._parent._parent.closeListTimer.removeEventListener(TimerEvent.TIMER, this._parent.closeColonyList);
        }

        [Bindable(event="propertyChange")]
        private function get btnEna():Boolean
        {
            return (this._1378835236btnEna);
        }

        public function set colonyNum(_arg_1:int):void
        {
            var _local_2:Object = this._1978309676colonyNum;
            if (_local_2 !== _arg_1)
            {
                this._1978309676colonyNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyNum", _local_2, _arg_1));
            };
        }

        private function loadOk():void
        {
            var _local_2:int;
            var _local_3:int;
            if (colonyArr.length > 0)
            {
                if (colonyArr.length <= 6)
                {
                    btnEna = false;
                }
                else
                {
                    btnEna = true;
                };
                itemArray = new ArrayCollection();
                _local_2 = 0;
                while (_local_2 < colonyArr.length)
                {
                    itemArray.addItem({
                        "cbean":colonyArr[_local_2],
                        "parent":this._parent._parent,
                        "castle":this.castleBean,
                        "pageN":(_local_2 + 1)
                    });
                    _local_2++;
                };
            };
            var _local_1:int = itemArray.length;
            this.colonyNum = _local_1;
            if (_local_1 < 6)
            {
                _local_3 = 0;
                while (_local_3 < (6 - _local_1))
                {
                    itemArray.addItem({
                        "cbean":null,
                        "parent":null,
                        "castle":null
                    });
                    _local_3++;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get colonyNum():int
        {
            return (this._1978309676colonyNum);
        }

        private function _ColonyList_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.isShowSuzerain;
            _local_1 = (!(this.isShowSuzerain));
            _local_1 = this.btnEna;
            _local_1 = this.btnEna;
            _local_1 = itemArray;
        }

        public function set colonyList(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1197987000colonyList;
            if (_local_2 !== _arg_1)
            {
                this._1197987000colonyList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyList", _local_2, _arg_1));
            };
        }


    }
}//package view.castleList

