// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.CheckApplyWin

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.formatters.DateFormatter;
    import mx.controls.DataGrid;
    import mx.core.ClassFactory;
    import mx.core.UIComponentDescriptor;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.client.action.ActionFactory;
    import mx.events.FlexEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.beans.AllianceAddPlayerByUserInfoBean;
    import com.evony.common.module.CommandResponse;
    import autoevony.event.popUpWinShowEvent;
    import autoevony.common.Utils;
    import com.evony.common.module.alliance.AllianceUserAddResponse;
    import com.evony.client.response.ResponseDispatcher;
    import mx.binding.Binding;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import flash.utils.getDefinitionByName;
    import flash.events.MouseEvent;
    import mx.binding.BindingManager;
    import mx.events.PropertyChangeEvent;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class CheckApplyWin extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1765123250formatDateTime:DateFormatter;
        public var _CheckApplyWin_DataGrid1:DataGrid;
        private var closeFunc:Function = null;
        public var _CheckApplyWin_ClassFactory1:ClassFactory;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":410,
                    "width":790,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"windowTitle":"Applications to Join"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "30";
                            this.top = "55";
                            this.bottom = "5";
                            this.right = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "7";
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___CheckApplyWin_Button1_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "7";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Return",
                                                        "styleName":"REwinBtn",
                                                        "width":75,
                                                        "x":250
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_CheckApplyWin_DataGrid1",
                                    "stylesFactory":function ():void
                                    {
                                        this.borderStyle = "solid";
                                        this.bottom = "36";
                                        this.top = "0";
                                        this.headerStyleName = "columnHeaderSyle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"REdataGrid",
                                            "draggableColumns":false,
                                            "percentWidth":100,
                                            "resizableColumns":false,
                                            "selectable":false,
                                            "sortableColumns":false,
                                            "x":0,
                                            "columns":[_CheckApplyWin_DataGridColumn1_c(), _CheckApplyWin_DataGridColumn2_c(), _CheckApplyWin_DataGridColumn3_c(), _CheckApplyWin_DataGridColumn4_c(), _CheckApplyWin_DataGridColumn5_c(), _CheckApplyWin_DataGridColumn6_c()]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___CheckApplyWin_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var _1515842358unionArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CheckApplyWin()
        {
            mx_internal::_document = this;
            this.height = 410;
            this.width = 790;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this._CheckApplyWin_DateFormatter1_i();
            this.addEventListener("creationComplete", this.___CheckApplyWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CheckApplyWin._watcherSetupUtil = _arg_1;
        }


        private function _CheckApplyWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.unionArray;
            _local_1 = CheckApply_inlineComponent2;
            _local_1 = this.propertiesObj;
        }

        private function get propertiesObj():Object
        {
            return ({"outerDocument":this});
        }

        public function showMembersMsg(_arg_1:Object, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceByLeader(_arg_1.userName);
            }
            else
            {
                ActionFactory.getInstance().getAllianceManagementCommands().cancelagreeComeinAlliance(_arg_1.userName);
            };
        }

        public function ___CheckApplyWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        private function _CheckApplyWin_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Player";
            _local_1.dataField = "userName";
            _local_1.width = 120;
            return (_local_1);
        }

        private function _CheckApplyWin_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Ranking";
            _local_1.dataField = "rank_formatted";
            _local_1.width = 100;
            return (_local_1);
        }

        private function _CheckApplyWin_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Prestige";
            _local_1.dataField = "prestige_formatted";
            _local_1.width = 100;
            return (_local_1);
        }

        private function _CheckApplyWin_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Cities";
            _local_1.dataField = "castleCount";
            _local_1.width = 80;
            return (_local_1);
        }

        private function onAgreeComeInAllianceList(_arg_1:AllianceUserAddResponse):void
        {
            var _local_2:Object;
            var _local_3:AllianceAddPlayerByUserInfoBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                _local_2 = new Object();
                this.unionArray = new ArrayCollection();
                for each (_local_3 in _arg_1.allianceAddPlayerByUserInfoBeanListArray)
                {
                    _local_2 = _local_3.toObject();
                    _local_2.applyTimeStr = this.formatDateTime.format(new Date(_local_3.inviteTime).toString());
                    _local_2.prestige_formatted = Utils.formatInt(_local_3.prestige);
                    _local_2.rank_formatted = Utils.formatInt(_local_3.rank);
                    this.unionArray.addItem(_local_2);
                };
            };
        }

        private function _CheckApplyWin_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Action";
            _local_1.dataField = "userName";
            _local_1.itemRenderer = this._CheckApplyWin_ClassFactory1_i();
            return (_local_1);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_LIST, this.onAgreeComeInAllianceList);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_LEADER, this.onAgreeComeInByLeader);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_CANCELAGREE_COMEIN_ALLIANCE, this.onCancelAgreeComeIn);
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function _CheckApplyWin_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Apply Time";
            _local_1.dataField = "applyTimeStr";
            _local_1.width = 140;
            return (_local_1);
        }

        private function _CheckApplyWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.unionArray);
            }, function (_arg_1:Object):void
            {
                _CheckApplyWin_DataGrid1.dataProvider = _arg_1;
            }, "_CheckApplyWin_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():Class
            {
                return (CheckApply_inlineComponent2);
            }, function (_arg_1:Class):void
            {
                _CheckApplyWin_ClassFactory1.generator = _arg_1;
            }, "_CheckApplyWin_ClassFactory1.generator");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.propertiesObj);
            }, function (_arg_1:Object):void
            {
                _CheckApplyWin_ClassFactory1.properties = _arg_1;
            }, "_CheckApplyWin_ClassFactory1.properties");
            result[2] = binding;
            return (result);
        }

        private function onAgreeComeInByLeader(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceList();
            };
        }

        override public function initialize():void
        {
            var target:CheckApplyWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._CheckApplyWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_CheckApplyWinWatcherSetupUtil");
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

        public function refresh():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceList();
        }

        private function onCancelAgreeComeIn(_arg_1:AllianceUserAddResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceList();
            };
        }

        public function updateInfo(_arg_1:Function=null):void
        {
            this.closeFunc = _arg_1;
        }

        public function ___CheckApplyWin_Button1_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function _CheckApplyWin_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._CheckApplyWin_ClassFactory1 = _local_1;
            BindingManager.executeBindings(this, "_CheckApplyWin_ClassFactory1", this._CheckApplyWin_ClassFactory1);
            return (_local_1);
        }

        public function set formatDateTime(_arg_1:DateFormatter):void
        {
            var _local_2:Object = this._1765123250formatDateTime;
            if (_local_2 !== _arg_1)
            {
                this._1765123250formatDateTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "formatDateTime", _local_2, _arg_1));
            };
        }

        private function _CheckApplyWin_DateFormatter1_i():DateFormatter
        {
            var _local_1:DateFormatter = new DateFormatter();
            this.formatDateTime = _local_1;
            _local_1.formatString = "MM/DD/YY JJ:NN";
            return (_local_1);
        }

        public function ___CheckApplyWin_Button2_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function set unionArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1515842358unionArray;
            if (_local_2 !== _arg_1)
            {
                this._1515842358unionArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "unionArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get formatDateTime():DateFormatter
        {
            return (this._1765123250formatDateTime);
        }

        [Bindable(event="propertyChange")]
        private function get unionArray():ArrayCollection
        {
            return (this._1515842358unionArray);
        }

        private function close():void
        {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_LIST, this.onAgreeComeInAllianceList);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_LEADER, this.onAgreeComeInByLeader);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_CANCELAGREE_COMEIN_ALLIANCE, this.onCancelAgreeComeIn);
            this.closeFunc.apply(null, [this]);
        }


    }
}//package autoevony.gui.info.Alliance

