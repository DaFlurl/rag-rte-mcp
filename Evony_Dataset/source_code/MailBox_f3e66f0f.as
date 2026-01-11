// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Mail.MailBox

package autoevony.gui.info.Mail
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.containers.VDividedBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import com.evony.client.action.ActionFactory;
    import autoevony.gui.MainScreen;
    import flash.events.MouseEvent;
    import mx.events.ListEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import autoevony.common.Utils;
    import com.evony.common.module.mail.MailResponse;
    import com.evony.common.beans.MailBean;
    import com.evony.common.module.mail.MailListResponse;
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

    public class MailBox extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private const PAGESIZE:int = 10;
        private var _855813086currentAllianceListPageNo:Label;
        private var _995752784pageNo:int = 1;
        private var _10267247mailType:int;
        private var _3203dg:DataGrid;
        private var _577409037totalPage:int = 1;
        private var _108401386reply:Button;
        private var _10813447mailBody:TextArea;
        private var _838846263update:Button;
        private var mailPending:int = -1;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "3";
                            this.right = "3";
                            this.top = "0";
                            this.bottom = "3";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.verticalGap = 0;
                                        this.horizontalGap = 2;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":32,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"update",
                                                "events":{"click":"__update_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"refreshBtn",
                                                        "toolTip":"Refresh"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":15});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___MailBox_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"previousBtn"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"currentAllianceListPageNo",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"REmainFormText"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___MailBox_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"nextBtn"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":80});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"reply",
                                                "events":{"click":"__reply_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Reply",
                                                        "styleName":"REwinBtn"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___MailBox_Button5_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Delete",
                                                        "styleName":"REwinBtn"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VDividedBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"dg",
                                                "events":{"change":"__dg_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.headerStyleName = "columnHeaderSyle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REdataGrid",
                                                        "allowDragSelection":false,
                                                        "allowMultipleSelection":false,
                                                        "doubleClickEnabled":false,
                                                        "dragEnabled":false,
                                                        "draggableColumns":false,
                                                        "editable":false,
                                                        "enabled":true,
                                                        "horizontalScrollPolicy":"off",
                                                        "minHeight":30,
                                                        "percentHeight":50,
                                                        "percentWidth":100,
                                                        "resizableColumns":true,
                                                        "rowHeight":23,
                                                        "selectable":true,
                                                        "showHeaders":true,
                                                        "sortableColumns":false,
                                                        "variableRowHeight":true,
                                                        "visible":true,
                                                        "wordWrap":false,
                                                        "columns":[_MailBox_DataGridColumn1_c(), _MailBox_DataGridColumn2_c(), _MailBox_DataGridColumn3_c(), _MailBox_DataGridColumn4_c(), _MailBox_DataGridColumn5_c()]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"mailBody",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "editable":false,
                                                        "styleName":"RElogBox",
                                                        "percentHeight":50,
                                                        "percentWidth":100
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var mailCached:Object = new Object();
        private var _441028067mailsArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MailBox()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___MailBox_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MailBox._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get mailBody():TextArea
        {
            return (this._10813447mailBody);
        }

        public function set mailBody(_arg_1:TextArea):void
        {
            var _local_2:Object = this._10813447mailBody;
            if (_local_2 !== _arg_1)
            {
                this._10813447mailBody = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailBody", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get dg():DataGrid
        {
            return (this._3203dg);
        }

        private function _MailBox_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.pageNo + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                currentAllianceListPageNo.text = _arg_1;
            }, "currentAllianceListPageNo.text");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.mailType == 1);
            }, function (_arg_1:Boolean):void
            {
                reply.visible = _arg_1;
            }, "reply.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.mailsArray);
            }, function (_arg_1:Object):void
            {
                dg.dataProvider = _arg_1;
            }, "dg.dataProvider");
            result[2] = binding;
            return (result);
        }

        public function set dg(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._3203dg;
            if (_local_2 !== _arg_1)
            {
                this._3203dg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dg", _local_2, _arg_1));
            };
        }

        public function set reply(_arg_1:Button):void
        {
            var _local_2:Object = this._108401386reply;
            if (_local_2 !== _arg_1)
            {
                this._108401386reply = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reply", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:MailBox;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._MailBox_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Mail_MailBoxWatcherSetupUtil");
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

        private function onDeleteBtn():void
        {
            if (this.dg.selectedIndex == -1)
            {
                return;
            };
            ActionFactory.getInstance().getMailCommands().deleteMail(("" + this.dg.selectedItem.mailid));
            this.mailsArray.removeItemAt(this.dg.selectedIndex);
            this.mailBody.text = "";
        }

        private function updateData(_arg_1:Object=null):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            if (_arg_1 != null)
            {
                this.pageNo = 1;
            };
            this.fetchPage(this.pageNo);
        }

        private function onReplyBtn():void
        {
            if (this.dg.selectedIndex == -1)
            {
                return;
            };
            var _local_1:MailsView = (parentDocument as MailsView);
            _local_1.mailsInfoStack.selectedIndex = 3;
            _local_1.write._clearAll();
            _local_1.write._subject.text = ("Reply:" + this.dg.selectedItem.title);
            _local_1.write._receivers.text = this.dg.selectedItem.sender;
            _local_1.write._message.setFocus();
        }

        private function onSelectMail():void
        {
            if (this.dg.selectedIndex == -1)
            {
                this.mailBody.text = "";
                return;
            };
            if (this.mailCached[("mail" + this.dg.selectedItem.mailid)] != undefined)
            {
                this.mailBody.text = this.mailCached[("mail" + this.dg.selectedItem.mailid)];
                return;
            };
            this.mailPending = this.dg.selectedItem.mailid;
            ActionFactory.getInstance().getMailCommands().readMail(this.dg.selectedItem.mailid, this.onReadMailResponse);
        }

        public function __reply_click(_arg_1:MouseEvent):void
        {
            this.onReplyBtn();
        }

        public function __dg_change(_arg_1:ListEvent):void
        {
            this.onSelectMail();
        }

        [Bindable(event="propertyChange")]
        public function get mailsArray():ArrayCollection
        {
            return (this._441028067mailsArray);
        }

        public function set update(_arg_1:Button):void
        {
            var _local_2:Object = this._838846263update;
            if (_local_2 !== _arg_1)
            {
                this._838846263update = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "update", _local_2, _arg_1));
            };
        }

        private function previousPage():void
        {
            if (this.pageNo <= 1)
            {
                return;
            };
            this.pageNo--;
            this.updateData();
        }

        private function nextPage():void
        {
            if (this.pageNo >= this.totalPage)
            {
                return;
            };
            this.pageNo++;
            this.updateData();
        }

        private function _MailBox_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Time";
            _local_1.dataField = "receiveTimeStr";
            _local_1.width = 0.22;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get pageNo():int
        {
            return (this._995752784pageNo);
        }

        private function init():void
        {
            addEventListener(FlexEvent.SHOW, this.updateData);
            if (this.mailType == 1)
            {
                addEventListener(Event.RENDER, this.onRender);
            };
        }

        private function onRefeshBtn():void
        {
            if (this.pageNo >= this.totalPage)
            {
                this.pageNo = this.totalPage;
            };
            if (this.pageNo <= 1)
            {
                this.pageNo = 1;
            };
            this.updateData();
        }

        private function _MailBox_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "To";
            _local_1.dataField = "receiver";
            _local_1.width = 0.2;
            return (_local_1);
        }

        public function set mailsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._441028067mailsArray;
            if (_local_2 !== _arg_1)
            {
                this._441028067mailsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailsArray", _local_2, _arg_1));
            };
        }

        public function set currentAllianceListPageNo(_arg_1:Label):void
        {
            var _local_2:Object = this._855813086currentAllianceListPageNo;
            if (_local_2 !== _arg_1)
            {
                this._855813086currentAllianceListPageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentAllianceListPageNo", _local_2, _arg_1));
            };
        }

        private function cleanupCache():void
        {
            var _local_2:String;
            var _local_1:Number = (Utils.getServerTime() - (3600 * 1000));
            for (_local_2 in this.mailCached)
            {
                if (String(_local_2).indexOf("mail") != 0)
                {
                    if (this.mailCached[_local_2] <= _local_1)
                    {
                        delete this.mailCached[_local_2];
                        delete this.mailCached[("mail" + _local_2)];
                    };
                };
            };
        }

        public function ___MailBox_Button5_click(_arg_1:MouseEvent):void
        {
            this.onDeleteBtn();
        }

        public function ___MailBox_Button3_click(_arg_1:MouseEvent):void
        {
            this.nextPage();
        }

        public function toDebugString():String
        {
            return ("fields: mailsArray pageNo totalPage, method: fetchPage(int), columns: isReadStr receiveTimeStr sender receiver title rawData");
        }

        private function onReadMailResponse(_arg_1:MailResponse):void
        {
            if (_arg_1.ok != 1)
            {
                return;
            };
            this.cleanupCache();
            this.mailCached[("mail" + _arg_1.mailid)] = ((("Subject: " + _arg_1.title) + "\n\n") + _arg_1.content);
            this.mailCached[_arg_1.mailid] = Utils.getServerTime();
            if (((!(this.dg.selectedIndex == -1)) && (this.dg.selectedItem.mailid == _arg_1.mailid)))
            {
                this.mailsArray[this.dg.selectedIndex].isReadStr = "Y";
                this.dg.invalidateList();
                this.mailBody.text = this.mailCached[("mail" + _arg_1.mailid)];
            };
        }

        public function set mailType(_arg_1:int):void
        {
            var _local_2:Object = this._10267247mailType;
            if (_local_2 !== _arg_1)
            {
                this._10267247mailType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailType", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get update():Button
        {
            return (this._838846263update);
        }

        private function onRender(_arg_1:Object):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            removeEventListener(Event.RENDER, this.onRender);
            this.updateData();
        }

        [Bindable(event="propertyChange")]
        public function get mailType():int
        {
            return (this._10267247mailType);
        }

        [Bindable(event="propertyChange")]
        public function get currentAllianceListPageNo():Label
        {
            return (this._855813086currentAllianceListPageNo);
        }

        private function _MailBox_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.pageNo + "/") + this.totalPage);
            _local_1 = (this.mailType == 1);
            _local_1 = this.mailsArray;
        }

        private function onMailListResponse(_arg_1:MailListResponse):void
        {
            var _local_4:MailBean;
            if (_arg_1.ok != 1)
            {
                return;
            };
            var _local_2:Object;
            var _local_3:Boolean = true;
            for each (_local_4 in _arg_1.mailsArray)
            {
                if (_local_3)
                {
                    _local_3 = false;
                    this.mailsArray.removeAll();
                    this.pageNo = _arg_1.pageNo;
                    this.totalPage = _arg_1.totalPage;
                };
                if (_local_4.type_id == this.mailType)
                {
                    _local_2 = _local_4.toObject();
                    _local_2.rawData = _local_4;
                    _local_2.isReadStr = ((_local_4.isRead) ? "Y" : "N");
                    _local_2.receiveTimeStr = _local_4.receiveTime;
                    this.mailsArray.addItem(_local_2);
                };
            };
        }

        private function _MailBox_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Read";
            _local_1.dataField = "isReadStr";
            _local_1.width = 0.08;
            return (_local_1);
        }

        public function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        private function _MailBox_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "From";
            _local_1.dataField = "sender";
            _local_1.width = 0.2;
            return (_local_1);
        }

        public function ___MailBox_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        public function fetchPage(_arg_1:int):void
        {
            ActionFactory.getInstance().getMailCommands().receiveMailList(_arg_1, this.mailType, this.PAGESIZE, this.onMailListResponse);
            this.pageNo = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get reply():Button
        {
            return (this._108401386reply);
        }

        public function set pageNo(_arg_1:int):void
        {
            var _local_2:Object = this._995752784pageNo;
            if (_local_2 !== _arg_1)
            {
                this._995752784pageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pageNo", _local_2, _arg_1));
            };
        }

        private function _MailBox_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Subject";
            _local_1.dataField = "title";
            _local_1.width = 0.6;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        public function __update_click(_arg_1:MouseEvent):void
        {
            this.onRefeshBtn();
        }

        [Bindable(event="propertyChange")]
        public function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        public function ___MailBox_Button2_click(_arg_1:MouseEvent):void
        {
            this.previousPage();
        }


    }
}//package autoevony.gui.info.Mail

