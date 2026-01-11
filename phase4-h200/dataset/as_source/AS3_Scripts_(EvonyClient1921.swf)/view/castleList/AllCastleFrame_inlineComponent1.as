// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.AllCastleFrame_inlineComponent1

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import com.evony.common.beans.CastleBean;
    import flash.utils.getDefinitionByName;
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

    public class AllCastleFrame_inlineComponent1 extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _114143939castleLogo:CastleLogo;
        private var _88844982outerDocument:AllCastleFrame;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":66,
                    "height":38,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":CastleLogo,
                        "id":"castleLogo",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":61,
                                "height":36
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllCastleFrame_inlineComponent1()
        {
            mx_internal::_document = this;
            this.width = 66;
            this.height = 38;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllCastleFrame_inlineComponent1._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get castleLogo():CastleLogo
        {
            return (this._114143939castleLogo);
        }

        public function set castleLogo(_arg_1:CastleLogo):void
        {
            var _local_2:Object = this._114143939castleLogo;
            if (_local_2 !== _arg_1)
            {
                this._114143939castleLogo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleLogo", _local_2, _arg_1));
            };
        }

        private function _AllCastleFrame_inlineComponent1_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():AllCastleFrame
            {
                return (data.parent);
            }, function (_arg_1:AllCastleFrame):void
            {
                castleLogo.setParent = _arg_1;
            }, "castleLogo.setParent");
            result[0] = binding;
            binding = new Binding(this, function ():CastleBean
            {
                return (data.castle as CastleBean);
            }, function (_arg_1:CastleBean):void
            {
                castleLogo.setCastle = _arg_1;
            }, "castleLogo.setCastle");
            result[1] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():AllCastleFrame
        {
            return (this._88844982outerDocument);
        }

        override public function initialize():void
        {
            var target:AllCastleFrame_inlineComponent1;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllCastleFrame_inlineComponent1_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_AllCastleFrame_inlineComponent1WatcherSetupUtil");
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

        public function set outerDocument(_arg_1:AllCastleFrame):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        private function _AllCastleFrame_inlineComponent1_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data.parent;
            _local_1 = (data.castle as CastleBean);
        }


    }
}//package view.castleList

