// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.ScoutResults

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.utils.ObjectProxy;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
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

    public class ScoutResults extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1003243718textarea:Text;
        private var _849030935myResult:String;
        private var _482300647scoutObj:ObjectProxy;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":300,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.right = "0";
                            this.top = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"textarea",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"nomalTextStyle",
                                            "percentWidth":100
                                        });
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ScoutResults()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.kerning = true;
            };
            this.width = 300;
            this.styleName = "wightBackGroundSimpleStyle";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ScoutResults._watcherSetupUtil = _arg_1;
        }


        private function _ScoutResults_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.myResult;
        }

        public function set myScoutObj(_arg_1:ObjectProxy):void
        {
            this.scoutObj = _arg_1;
            if ((((this.scoutObj.isAttack == true) && (this.scoutObj.isFound == false)) && (this.scoutObj.isSuccess == false)))
            {
                this.myResult = Lang.msg("侦察部队被正规军发现，被全歼，无侦察报告");
                return;
            };
            if ((((this.scoutObj.isAttack == true) && (this.scoutObj.isFound == false)) && (this.scoutObj.isSuccess == true)))
            {
                this.myResult = Lang.msg("侦察部队被正规军发现，但因对方正规军数量少不中与我方侦察部队抗衡，我方胜。");
                return;
            };
            if ((((this.scoutObj.isAttack == true) && (this.scoutObj.isFound == true)) && (this.scoutObj.isSuccess == false)))
            {
                this.myResult = Lang.msg("侦察部队成功潜入，但与第三方侦察兵发生战斗被全歼，无侦察报告带回。");
                return;
            };
            if ((((this.scoutObj.isAttack == true) && (this.scoutObj.isFound == true)) && (this.scoutObj.isSuccess == true)))
            {
                this.myResult = Lang.msg("侦察部队成功潜入敌城，但与敌方侦察兵发生战斗，部队中部分人员生还带回报告。");
                return;
            };
            if (((this.scoutObj.isAttack == false) && (this.scoutObj.isSuccess == false)))
            {
                this.myResult = Lang.msg("对方侦察部队被我方全歼。");
                return;
            };
            if (((this.scoutObj.isAttack == false) && (this.scoutObj.isSuccess == true)))
            {
                this.myResult = Lang.msg("对方侦察部队战胜我方，对方侦察成功。");
                return;
            };
            this.myResult = "";
        }

        override public function initialize():void
        {
            var target:ScoutResults;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ScoutResults_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_ScoutResultsWatcherSetupUtil");
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

        private function set myResult(_arg_1:String):void
        {
            var _local_2:Object = this._849030935myResult;
            if (_local_2 !== _arg_1)
            {
                this._849030935myResult = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myResult", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get scoutObj():ObjectProxy
        {
            return (this._482300647scoutObj);
        }

        private function _ScoutResults_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.myResult;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                textarea.text = _arg_1;
            }, "textarea.text");
            result[0] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get myResult():String
        {
            return (this._849030935myResult);
        }

        private function set scoutObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._482300647scoutObj;
            if (_local_2 !== _arg_1)
            {
                this._482300647scoutObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scoutObj", _local_2, _arg_1));
            };
        }

        public function set textarea(_arg_1:Text):void
        {
            var _local_2:Object = this._1003243718textarea;
            if (_local_2 !== _arg_1)
            {
                this._1003243718textarea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textarea", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get textarea():Text
        {
            return (this._1003243718textarea);
        }


    }
}//package view.module.info.reports.ReportUi

