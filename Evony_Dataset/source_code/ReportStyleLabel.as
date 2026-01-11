// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.ReportStyleLabel

package view.module.info
{
    import mx.controls.Label;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.ReportBean;
    import com.evony.common.constants.MailConstants;
    import com.evony.util.TextColorConstants;
    import com.evony.common.constants.ObjConstants;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.core.mx_internal;
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

    public class ReportStyleLabel extends Label implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var reportBean:ReportBean;
        private var _1088389232myStyleName:String;

        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};


        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ReportStyleLabel._watcherSetupUtil = _arg_1;
        }


        public function set myReport(_arg_1:Object):void
        {
            this.reportBean = (_arg_1 as ReportBean);
            switch (this.reportBean.type)
            {
                case ObjConstants.REPORT_TYPE_SCOUT:
                    if (this.reportBean.isRead == MailConstants.IS_READ)
                    {
                        this.myStyleName = "commonNormalColor";
                    }
                    else
                    {
                        if (this.reportBean.isRead == MailConstants.NOT_READ)
                        {
                            this.myStyleName = "focusColor";
                        };
                    };
                    if (this.reportBean.back)
                    {
                        this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_USUAL_COLOR : TextColorConstants.COMMON_USUAL_COLOR_NOT_READ);
                    }
                    else
                    {
                        this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_WORNING_COLOR : TextColorConstants.COMMON_WORNING_COLOR_NOT_READ);
                    };
                    return;
                case ObjConstants.REPORT_TYPE_TRADE:
                    if (this.reportBean.isRead == MailConstants.IS_READ)
                    {
                        this.myStyleName = "commonNormalColor";
                    }
                    else
                    {
                        if (this.reportBean.isRead == MailConstants.NOT_READ)
                        {
                            this.myStyleName = "focusColor";
                            this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_USUAL_COLOR : TextColorConstants.COMMON_USUAL_COLOR_NOT_READ);
                        };
                    };
                    return;
                case ObjConstants.REPORT_TYPE_OTHER:
                    if (this.reportBean.isRead == MailConstants.IS_READ)
                    {
                        this.myStyleName = "commonNormalColor";
                    }
                    else
                    {
                        if (this.reportBean.isRead == MailConstants.NOT_READ)
                        {
                            this.myStyleName = "focusColor";
                            this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_USUAL_COLOR : TextColorConstants.COMMON_USUAL_COLOR_NOT_READ);
                        };
                    };
                    return;
                case ObjConstants.REPORT_TYPE_ARMY:
                    switch (this.reportBean.armyType)
                    {
                        case ObjConstants.ARMY_MISSION_TRANS:
                            if (this.reportBean.back)
                            {
                                this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_USUAL_COLOR : TextColorConstants.COMMON_USUAL_COLOR_NOT_READ);
                            }
                            else
                            {
                                this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_GOOD_COLOR : TextColorConstants.COMMON_GOOD_COLOR_NOT_READ);
                            };
                            break;
                        case ObjConstants.ARMY_MISSION_SEND:
                            if (this.reportBean.back)
                            {
                                this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_USUAL_COLOR : TextColorConstants.COMMON_USUAL_COLOR_NOT_READ);
                            }
                            else
                            {
                                this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_GOOD_COLOR : TextColorConstants.COMMON_GOOD_COLOR_NOT_READ);
                            };
                            break;
                        case ObjConstants.ARMY_MISSION_CONSTRUCT:
                            this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_GOOD_COLOR : TextColorConstants.COMMON_GOOD_COLOR_NOT_READ);
                            break;
                        case ObjConstants.ARMY_MISSION_OCCUPY:
                            if (this.reportBean.back)
                            {
                                this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_USUAL_COLOR : TextColorConstants.COMMON_USUAL_COLOR_NOT_READ);
                            }
                            else
                            {
                                this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_WORNING_COLOR : TextColorConstants.COMMON_WORNING_COLOR_NOT_READ);
                            };
                            break;
                        case ObjConstants.ARMY_DECLARED_WAR:
                            this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_WORNING_COLOR : TextColorConstants.COMMON_WORNING_COLOR_NOT_READ);
                            break;
                        default:
                            this.myStyleName = ((this.reportBean.isRead == 1) ? TextColorConstants.COMMON_USUAL_COLOR : TextColorConstants.COMMON_USUAL_COLOR_NOT_READ);
                    };
                    return;
                default:
                    this.myStyleName = "commonNormalColor";
            };
        }

        private function _ReportStyleLabel_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = myStyleName;
        }

        private function _ReportStyleLabel_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (myStyleName);
            }, function (_arg_1:Object):void
            {
                this.styleName = _arg_1;
            }, "this.styleName");
            result[0] = binding;
            return (result);
        }

        private function set myStyleName(_arg_1:String):void
        {
            var _local_2:Object = this._1088389232myStyleName;
            if (_local_2 !== _arg_1)
            {
                this._1088389232myStyleName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myStyleName", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:ReportStyleLabel;
            var watcherSetupUtilClass:Object;
            var bindings:Array = _ReportStyleLabel_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_ReportStyleLabelWatcherSetupUtil");
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
        private function get myStyleName():String
        {
            return (this._1088389232myStyleName);
        }


    }
}//package view.module.info

