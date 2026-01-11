// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.immediateNotice.NoticeWin

package view.module.immediateNotice
{
    import view.ui.BaseFunctionWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.core.ClassFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.events.FlexEvent;
    import com.evony.client.action.ActionFactory;
    import mx.events.PropertyChangeEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.module.mail.TVResponse;
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

    public class NoticeWin extends BaseFunctionWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "NoticeWin.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _NoticeWin_DataGrid1:DataGrid;
        private var _737449617notice_htmlMsg:String = "";

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "34";
                            this.top = "42";
                            this.right = "34";
                            this.bottom = "16";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_NoticeWin_DataGrid1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "0";
                                        this.bottom = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"style2",
                                            "showHeaders":false,
                                            "percentWidth":100,
                                            "variableRowHeight":true,
                                            "minHeight":25,
                                            "maxHeight":50,
                                            "columns":[_NoticeWin_DataGridColumn1_c()]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var _1102509654listDP:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function NoticeWin()
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
            };
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this.addEventListener("creationComplete", ___NoticeWin_BaseFunctionWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            NoticeWin._watcherSetupUtil = _arg_1;
        }


        private function _NoticeWin_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = NoticeWin_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:NoticeWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _NoticeWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_immediateNotice_NoticeWinWatcherSetupUtil");
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

        private function _NoticeWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("传闻");
            _local_1 = listDP;
        }

        private function _NoticeWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("传闻");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (listDP);
            }, function (_arg_1:Object):void
            {
                _NoticeWin_DataGrid1.dataProvider = _arg_1;
            }, "_NoticeWin_DataGrid1.dataProvider");
            result[1] = binding;
            return (result);
        }

        public function ___NoticeWin_BaseFunctionWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        override public function refresh():void
        {
            ActionFactory.getInstance().getMailCommands().getAllTVMsg(onGetAllTVMsg);
        }

        private function set notice_htmlMsg(_arg_1:String):void
        {
            var _local_2:Object = this._737449617notice_htmlMsg;
            if (_local_2 !== _arg_1)
            {
                this._737449617notice_htmlMsg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "notice_htmlMsg", _local_2, _arg_1));
            };
        }

        private function init():void
        {
        }

        private function set listDP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1102509654listDP;
            if (_local_2 !== _arg_1)
            {
                this._1102509654listDP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "listDP", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get listDP():ArrayCollection
        {
            return (this._1102509654listDP);
        }

        [Bindable(event="propertyChange")]
        private function get notice_htmlMsg():String
        {
            return (this._737449617notice_htmlMsg);
        }

        private function _NoticeWin_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.itemRenderer = _NoticeWin_ClassFactory1_c();
            return (_local_1);
        }

        private function onGetAllTVMsg(_arg_1:TVResponse):void
        {
            if (_arg_1.ok)
            {
                listDP = new ArrayCollection(_arg_1.tvBeansArray.toArray().reverse());
            };
        }


    }
}//package view.module.immediateNotice

