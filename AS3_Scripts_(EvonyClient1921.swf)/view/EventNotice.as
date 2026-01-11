// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.EventNotice

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.SWFLoader;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.binding.Binding;
    import com.evony.util.ResourceLoader;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import flash.events.MouseEvent;
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

    public class EventNotice extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var type:String;
        private var _104387img:Image;
        private var _3540562star:SWFLoader;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"img",
                        "events":{
                            "complete":"__img_complete",
                            "click":"__img_click"
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "y":0,
                                "source":"images/feed/star5.png"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"star",
                        "events":{"click":"__star_click"}
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function EventNotice()
        {
            mx_internal::_document = this;
            this.addEventListener("creationComplete", ___EventNotice_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            EventNotice._watcherSetupUtil = _arg_1;
        }


        private function _EventNotice_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (ResourceLoader.getNormalUrl("fla/star.swf"));
            }, function (_arg_1:Object):void
            {
                star.source = _arg_1;
            }, "star.source");
            result[0] = binding;
            return (result);
        }

        public function set img(_arg_1:Image):void
        {
            var _local_2:Object = this._104387img;
            if (_local_2 !== _arg_1)
            {
                this._104387img = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "img", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:EventNotice;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _EventNotice_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_EventNoticeWatcherSetupUtil");
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
        public function get img():Image
        {
            return (this._104387img);
        }

        public function __img_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function init():void
        {
        }

        [Bindable(event="propertyChange")]
        public function get star():SWFLoader
        {
            return (this._3540562star);
        }

        public function set star(_arg_1:SWFLoader):void
        {
            var _local_2:Object = this._3540562star;
            if (_local_2 !== _arg_1)
            {
                this._3540562star = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "star", _local_2, _arg_1));
            };
        }

        private function _EventNotice_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ResourceLoader.getNormalUrl("fla/star.swf");
        }

        public function ___EventNotice_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function __img_click(_arg_1:MouseEvent):void
        {
            clickStar();
        }

        private function clickStar():void
        {
            this.visible = false;
            RandomEventWin.show(4);
        }

        public function __star_click(_arg_1:MouseEvent):void
        {
            clickStar();
        }


    }
}//package view

