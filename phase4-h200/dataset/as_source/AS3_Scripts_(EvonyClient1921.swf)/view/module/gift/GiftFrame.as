// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.gift.GiftFrame

package view.module.gift
{
    import view.ui.BaseFunctionWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.controls.Text;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.collections.ArrayCollection;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.controls.Label;
    import mx.core.mx_internal;
    import mx.core.ClassFactory;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.common.module.common.GetPackageResponse;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.beans.PackageBean;
    import com.evony.common.constants.ObjConstants;
    import com.evony.client.action.ActionFactory;
    import mx.binding.BindingManager;
    import view.module.shop.ShopWin;
    import com.evony.common.module.common.GetPackageListResponse;
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

    public class GiftFrame extends BaseFunctionWindow implements IBindingClient 
    {

        public static var EVENT_SHOW:String = "GiftFrame.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _GiftFrame_DataGrid1:DataGrid;
        public var _GiftFrame_DataGrid2:DataGrid;
        public var _GiftFrame_Text1:Text;
        public var _GiftFrame_DataGridColumn1:DataGridColumn;
        public var _GiftFrame_DataGridColumn2:DataGridColumn;
        public var _GiftFrame_DataGridColumn3:DataGridColumn;
        public var _GiftFrame_DataGridColumn4:DataGridColumn;
        private var _750867658packageP:ArrayCollection;
        private var i:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.right = "32";
                            this.left = "32";
                            this.top = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":70,
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_GiftFrame_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "20";
                                        this.bottom = "10";
                                        this.left = "20";
                                        this.top = "10";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText2",
                                            "selectable":false
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_GiftFrame_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.left = "32";
                            this.right = "32";
                            this.top = "130";
                            this.bottom = "170";
                            this.borderStyle = "solid";
                            this.borderThickness = 1;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_GiftFrame_DataGridColumn1_i(), _GiftFrame_DataGridColumn2_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_GiftFrame_DataGrid2",
                        "stylesFactory":function ():void
                        {
                            this.left = "32";
                            this.right = "32";
                            this.top = "360";
                            this.bottom = "16";
                            this.borderStyle = "solid";
                            this.borderThickness = 1;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "showHeaders":false,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_GiftFrame_DataGridColumn3_i(), _GiftFrame_DataGridColumn4_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.left = "32";
                            this.right = "32";
                            this.color = 0x450000;
                            this.fontSize = 12;
                            this.textAlign = "center";
                            this.top = "110";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"text":"Unclaimed"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.left = "32";
                            this.right = "32";
                            this.color = 0x450000;
                            this.fontSize = 12;
                            this.textAlign = "center";
                            this.top = "340";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"text":"Claimed"});
                        }
                    })]});
            }
        });
        private var _683025877claimedP:ArrayCollection = new ArrayCollection();
        private var _2021068914unClaimedP:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function GiftFrame()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            GiftFrame._watcherSetupUtil = _arg_1;
        }


        private function _GiftFrame_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = GiftFrame_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function getGiftResponse(_arg_1:GetPackageResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.refresh();
                AlertWin.show(Lang.msg("领取成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        override public function initialize():void
        {
            var target:GiftFrame;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _GiftFrame_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_gift_GiftFrameWatcherSetupUtil");
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

        private function _GiftFrame_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = GiftFrame_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _GiftFrame_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("我的礼包");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("礼包系统文字");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GiftFrame_Text1.text = _arg_1;
            }, "_GiftFrame_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (unClaimedP);
            }, function (_arg_1:Object):void
            {
                _GiftFrame_DataGrid1.dataProvider = _arg_1;
            }, "_GiftFrame_DataGrid1.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("礼包名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GiftFrame_DataGridColumn1.headerText = _arg_1;
            }, "_GiftFrame_DataGridColumn1.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("领取状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GiftFrame_DataGridColumn2.headerText = _arg_1;
            }, "_GiftFrame_DataGridColumn2.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (claimedP);
            }, function (_arg_1:Object):void
            {
                _GiftFrame_DataGrid2.dataProvider = _arg_1;
            }, "_GiftFrame_DataGrid2.dataProvider");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("礼包名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GiftFrame_DataGridColumn3.headerText = _arg_1;
            }, "_GiftFrame_DataGridColumn3.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("领取状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _GiftFrame_DataGridColumn4.headerText = _arg_1;
            }, "_GiftFrame_DataGridColumn4.headerText");
            result[7] = binding;
            return (result);
        }

        private function set unClaimedP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2021068914unClaimedP;
            if (_local_2 !== _arg_1)
            {
                this._2021068914unClaimedP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "unClaimedP", _local_2, _arg_1));
            };
        }

        private function set packageP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._750867658packageP;
            if (_local_2 !== _arg_1)
            {
                this._750867658packageP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "packageP", _local_2, _arg_1));
            };
        }

        public function getGift(_arg_1:Object):void
        {
            var _local_2:PackageBean = (_arg_1 as PackageBean);
            if (_local_2.status == ObjConstants.PACKAGE_STATUS_SERIAL)
            {
                return;
            };
            if (_local_2.status == ObjConstants.PACKAGE_STATUS_AVAIBLE)
            {
                ActionFactory.getInstance().getCommonCommands().getPackage(_local_2.id, "", getGiftResponse);
            };
        }

        private function set claimedP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._683025877claimedP;
            if (_local_2 !== _arg_1)
            {
                this._683025877claimedP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "claimedP", _local_2, _arg_1));
            };
        }

        public function showPackageContent(_arg_1:Object):void
        {
            PackageContent.show(_arg_1);
        }

        private function _GiftFrame_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _GiftFrame_DataGridColumn2 = _local_1;
            _local_1.dataField = "status";
            _local_1.itemRenderer = _GiftFrame_ClassFactory2_c();
            BindingManager.executeBindings(this, "_GiftFrame_DataGridColumn2", _GiftFrame_DataGridColumn2);
            return (_local_1);
        }

        private function _GiftFrame_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _GiftFrame_DataGridColumn4 = _local_1;
            _local_1.dataField = "status";
            _local_1.itemRenderer = _GiftFrame_ClassFactory4_c();
            BindingManager.executeBindings(this, "_GiftFrame_DataGridColumn4", _GiftFrame_DataGridColumn4);
            return (_local_1);
        }

        private function _GiftFrame_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("我的礼包");
            _local_1 = Lang.msg("礼包系统文字");
            _local_1 = unClaimedP;
            _local_1 = Lang.msg("礼包名称");
            _local_1 = Lang.msg("领取状态");
            _local_1 = claimedP;
            _local_1 = Lang.msg("礼包名称");
            _local_1 = Lang.msg("领取状态");
        }

        [Bindable(event="propertyChange")]
        private function get unClaimedP():ArrayCollection
        {
            return (this._2021068914unClaimedP);
        }

        private function _GiftFrame_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = GiftFrame_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _GiftFrame_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = GiftFrame_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function packgetListRosponse(_arg_1:GetPackageListResponse):void
        {
            var _local_4:int;
            var _local_2:ArrayCollection = new ArrayCollection();
            var _local_3:ArrayCollection = new ArrayCollection();
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (ShopWin.instance != null)
                {
                    ShopWin.packgetListRosponse(_arg_1);
                };
                packageP = _arg_1.packagesArray;
                _local_4 = 0;
                while (_local_4 < packageP.length)
                {
                    if (packageP[_local_4].status == ObjConstants.PACKAGE_STATUS_HAD_GOT)
                    {
                        _local_2.addItem(packageP[_local_4]);
                    }
                    else
                    {
                        _local_3.addItem(packageP[_local_4]);
                    };
                    _local_4++;
                };
                this.claimedP = _local_2;
                this.unClaimedP = _local_3;
            }
            else
            {
                packageP = null;
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get packageP():ArrayCollection
        {
            return (this._750867658packageP);
        }

        [Bindable(event="propertyChange")]
        private function get claimedP():ArrayCollection
        {
            return (this._683025877claimedP);
        }

        override public function refresh():void
        {
            super.refresh();
            ActionFactory.getInstance().getCommonCommands().getPackageList(packgetListRosponse);
            ActionFactory.getInstance().getCommonCommands().getPackageNumber();
        }

        private function _GiftFrame_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _GiftFrame_DataGridColumn1 = _local_1;
            _local_1.dataField = "packageName";
            _local_1.width = 375;
            _local_1.itemRenderer = _GiftFrame_ClassFactory1_c();
            BindingManager.executeBindings(this, "_GiftFrame_DataGridColumn1", _GiftFrame_DataGridColumn1);
            return (_local_1);
        }

        private function _GiftFrame_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _GiftFrame_DataGridColumn3 = _local_1;
            _local_1.dataField = "packageName";
            _local_1.width = 375;
            _local_1.itemRenderer = _GiftFrame_ClassFactory3_c();
            BindingManager.executeBindings(this, "_GiftFrame_DataGridColumn3", _GiftFrame_DataGridColumn3);
            return (_local_1);
        }


    }
}//package view.module.gift

