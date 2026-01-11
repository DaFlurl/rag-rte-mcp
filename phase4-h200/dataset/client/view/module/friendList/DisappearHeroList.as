// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.friendList.DisappearHeroList

package view.module.friendList
{
    import view.ui.BaseFunctionWindowEx;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import com.evony.common.beans.DisappearHeroBean;
    import mx.containers.ViewStack;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import com.evony.Lang;
    import mx.collections.ArrayCollection;
    import com.evony.Context;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import view.ui.AlertWin;
    import com.evony.common.module.CommandResponse;
    import mx.binding.BindingManager;
    import com.evony.common.module.hero.DisappearHeroResponse;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import mx.core.ClassFactory;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.client.action.ActionFactory;
    import mx.events.FlexEvent;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import mx.collections.*;
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

    public class DisappearHeroList extends BaseFunctionWindowEx implements IBindingClient 
    {

        public static var instance:DisappearHeroList;
        public static const EVENT_SHOW:String = "DisappearHeroList.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1165016872friendsDG:DataGrid;
        private var _1436069623selectedIndex:int;
        private var curBean:DisappearHeroBean;
        private var isFlag:Boolean = true;
        private var _577409037totalPage:Number = 0;
        private var _1125923055curPage:int = 1;
        private var _946505330viewstack1:ViewStack;
        public var _DisappearHeroList_DataGridColumn1:DataGridColumn;
        public var _DisappearHeroList_DataGridColumn2:DataGridColumn;
        public var _DisappearHeroList_DataGridColumn3:DataGridColumn;
        public var _DisappearHeroList_DataGridColumn4:DataGridColumn;
        public var _DisappearHeroList_DataGridColumn7:DataGridColumn;
        public var _DisappearHeroList_DataGridColumn5:DataGridColumn;
        private var userName:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindowEx,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "85";
                            this.top = "96";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":700,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"friendVs",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"friendsDG",
                                                "stylesFactory":function ():void
                                                {
                                                    this.borderStyle = "solid";
                                                    this.borderThickness = 1;
                                                    this.top = "0";
                                                    this.verticalAlign = "middle";
                                                    this.left = "0";
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "rowHeight":35,
                                                        "rowCount":10,
                                                        "verticalScrollPolicy":"auto",
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":true,
                                                        "percentWidth":100,
                                                        "columns":[_DisappearHeroList_DataGridColumn1_i(), _DisappearHeroList_DataGridColumn2_i(), _DisappearHeroList_DataGridColumn3_i(), _DisappearHeroList_DataGridColumn4_i(), _DisappearHeroList_DataGridColumn5_i(), _DisappearHeroList_DataGridColumn6_c(), _DisappearHeroList_DataGridColumn7_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _1591135199viewLable:String = Lang.msg("查看");
        private var _2130926892blockPlayerInfoAry:ArrayCollection = Context.getInstance().getPlayerBean().blockBeansArray;
        private var _1481557317friendPlayerInfoAry:ArrayCollection = Context.getInstance().getPlayerBean().friendBeansArray;
        private var _1149398893eachPageFriendArr:ArrayCollection = new ArrayCollection();
        private var _1079747868eachPageBlockArr:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function DisappearHeroList()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.title = "RESTORE YOUR HERO";
            this.addEventListener("creationComplete", ___DisappearHeroList_BaseFunctionWindowEx1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            DisappearHeroList._watcherSetupUtil = _arg_1;
        }


        private function set friendPlayerInfoAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1481557317friendPlayerInfoAry;
            if (_local_2 !== _arg_1)
            {
                this._1481557317friendPlayerInfoAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendPlayerInfoAry", _local_2, _arg_1));
            };
        }

        private function _DisappearHeroList_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Dismissed Time";
            _local_1.sortable = true;
            _local_1.dataField = "disppeartime";
            _local_1.itemRenderer = _DisappearHeroList_ClassFactory1_c();
            return (_local_1);
        }

        private function onHeroRecoverResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == 2)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
        }

        private function _DisappearHeroList_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _DisappearHeroList_DataGridColumn4 = _local_1;
            _local_1.sortable = true;
            _local_1.dataField = "power";
            BindingManager.executeBindings(this, "_DisappearHeroList_DataGridColumn4", _DisappearHeroList_DataGridColumn4);
            return (_local_1);
        }

        private function onHeroListResponse(_arg_1:DisappearHeroResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                friendPlayerInfoAry = _arg_1.herosArray;
            };
        }

        private function _DisappearHeroList_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():int
            {
                return (this.selectedIndex);
            }, function (_arg_1:int):void
            {
                viewstack1.selectedIndex = _arg_1;
            }, "viewstack1.selectedIndex");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.friendPlayerInfoAry);
            }, function (_arg_1:Object):void
            {
                friendsDG.dataProvider = _arg_1;
            }, "friendsDG.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("英雄名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DisappearHeroList_DataGridColumn1.headerText = _arg_1;
            }, "_DisappearHeroList_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DisappearHeroList_DataGridColumn2.headerText = _arg_1;
            }, "_DisappearHeroList_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("内政");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DisappearHeroList_DataGridColumn3.headerText = _arg_1;
            }, "_DisappearHeroList_DataGridColumn3.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("勇武");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DisappearHeroList_DataGridColumn4.headerText = _arg_1;
            }, "_DisappearHeroList_DataGridColumn4.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("智谋");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DisappearHeroList_DataGridColumn5.headerText = _arg_1;
            }, "_DisappearHeroList_DataGridColumn5.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("操作");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _DisappearHeroList_DataGridColumn7.headerText = _arg_1;
            }, "_DisappearHeroList_DataGridColumn7.headerText");
            result[7] = binding;
            return (result);
        }

        private function _DisappearHeroList_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _DisappearHeroList_DataGridColumn2 = _local_1;
            _local_1.sortable = true;
            _local_1.dataField = "level";
            BindingManager.executeBindings(this, "_DisappearHeroList_DataGridColumn2", _DisappearHeroList_DataGridColumn2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        override public function initialize():void
        {
            var target:DisappearHeroList;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _DisappearHeroList_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_friendList_DisappearHeroListWatcherSetupUtil");
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
        public function get viewLable():String
        {
            return (this._1591135199viewLable);
        }

        [Bindable(event="propertyChange")]
        private function get eachPageFriendArr():ArrayCollection
        {
            return (this._1149398893eachPageFriendArr);
        }

        private function _DisappearHeroList_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.selectedIndex;
            _local_1 = this.friendPlayerInfoAry;
            _local_1 = Lang.msg("英雄名称");
            _local_1 = Lang.msg("等级");
            _local_1 = Lang.msg("内政");
            _local_1 = Lang.msg("勇武");
            _local_1 = Lang.msg("智谋");
            _local_1 = Lang.msg("操作");
        }

        private function set eachPageFriendArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1149398893eachPageFriendArr;
            if (_local_2 !== _arg_1)
            {
                this._1149398893eachPageFriendArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eachPageFriendArr", _local_2, _arg_1));
            };
        }

        private function _DisappearHeroList_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = DisappearHeroList_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function init():void
        {
            instance = this;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO__GET_DISAPPEAR_HEROS, onHeroListResponse, false, 0, true);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO__RECOVER_DISAPPEAR_HERO, onHeroRecoverResponse, false, 0, true);
        }

        public function set viewstack1(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505330viewstack1;
            if (_local_2 !== _arg_1)
            {
                this._946505330viewstack1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack1", _local_2, _arg_1));
            };
        }

        public function restoreHero(_arg_1:DisappearHeroBean):void
        {
            curBean = _arg_1;
            ActionFactory.getInstance().getHeroCommand().RecoverDisappearHero(Context.getInstance().getCurCastle().id, _arg_1.id);
            instance.onClose(null);
        }

        public function ___DisappearHeroList_BaseFunctionWindowEx1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set friendsDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1165016872friendsDG;
            if (_local_2 !== _arg_1)
            {
                this._1165016872friendsDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendsDG", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get blockPlayerInfoAry():ArrayCollection
        {
            return (this._2130926892blockPlayerInfoAry);
        }

        public function set viewLable(_arg_1:String):void
        {
            var _local_2:Object = this._1591135199viewLable;
            if (_local_2 !== _arg_1)
            {
                this._1591135199viewLable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewLable", _local_2, _arg_1));
            };
        }

        private function set eachPageBlockArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1079747868eachPageBlockArr;
            if (_local_2 !== _arg_1)
            {
                this._1079747868eachPageBlockArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eachPageBlockArr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get friendPlayerInfoAry():ArrayCollection
        {
            return (this._1481557317friendPlayerInfoAry);
        }

        private function _DisappearHeroList_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _DisappearHeroList_DataGridColumn1 = _local_1;
            _local_1.dataField = "name";
            BindingManager.executeBindings(this, "_DisappearHeroList_DataGridColumn1", _DisappearHeroList_DataGridColumn1);
            return (_local_1);
        }

        private function _DisappearHeroList_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _DisappearHeroList_DataGridColumn5 = _local_1;
            _local_1.sortable = true;
            _local_1.dataField = "stratagem";
            BindingManager.executeBindings(this, "_DisappearHeroList_DataGridColumn5", _DisappearHeroList_DataGridColumn5);
            return (_local_1);
        }

        private function set curPage(_arg_1:int):void
        {
            var _local_2:Object = this._1125923055curPage;
            if (_local_2 !== _arg_1)
            {
                this._1125923055curPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPage", _local_2, _arg_1));
            };
        }

        private function _DisappearHeroList_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _DisappearHeroList_DataGridColumn7 = _local_1;
            _local_1.dataField = "userName";
            _local_1.width = 80;
            _local_1.itemRenderer = _DisappearHeroList_ClassFactory2_c();
            BindingManager.executeBindings(this, "_DisappearHeroList_DataGridColumn7", _DisappearHeroList_DataGridColumn7);
            return (_local_1);
        }

        private function _DisappearHeroList_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = DisappearHeroList_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        override public function refresh():void
        {
            ActionFactory.getInstance().getHeroCommand().GetDisappearHeros();
        }

        private function _DisappearHeroList_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _DisappearHeroList_DataGridColumn3 = _local_1;
            _local_1.sortable = true;
            _local_1.dataField = "management";
            BindingManager.executeBindings(this, "_DisappearHeroList_DataGridColumn3", _DisappearHeroList_DataGridColumn3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get eachPageBlockArr():ArrayCollection
        {
            return (this._1079747868eachPageBlockArr);
        }

        private function set totalPage(_arg_1:Number):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get friendsDG():DataGrid
        {
            return (this._1165016872friendsDG);
        }

        [Bindable(event="propertyChange")]
        private function get curPage():int
        {
            return (this._1125923055curPage);
        }

        private function set blockPlayerInfoAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2130926892blockPlayerInfoAry;
            if (_local_2 !== _arg_1)
            {
                this._2130926892blockPlayerInfoAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "blockPlayerInfoAry", _local_2, _arg_1));
            };
        }

        private function set selectedIndex(_arg_1:int):void
        {
            var _local_2:Object = this._1436069623selectedIndex;
            if (_local_2 !== _arg_1)
            {
                this._1436069623selectedIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectedIndex", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get selectedIndex():int
        {
            return (this._1436069623selectedIndex);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():Number
        {
            return (this._577409037totalPage);
        }


    }
}//package view.module.friendList

