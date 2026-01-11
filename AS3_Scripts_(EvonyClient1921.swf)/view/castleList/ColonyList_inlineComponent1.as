// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.ColonyList_inlineComponent1

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Image;
    import mx.core.mx_internal;
    import com.evony.common.beans.ColonyBean;
    import com.evony.common.beans.CastleBean;
    import mx.binding.Binding;
    import mx.collections.ArrayCollection;
    import flash.utils.getDefinitionByName;
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

    public class ColonyList_inlineComponent1 extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ColonyList_inlineComponent1_ColonyLogo1:ColonyLogo;
        private var _88844982outerDocument:ColonyList;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":70,
                    "height":40,
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
                        "type":ColonyLogo,
                        "id":"_ColonyList_inlineComponent1_ColonyLogo1",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":60,
                                "height":33
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

        public function ColonyList_inlineComponent1()
        {
            mx_internal::_document = this;
            this.width = 70;
            this.height = 40;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonyList_inlineComponent1._watcherSetupUtil = _arg_1;
        }


        private function _ColonyList_inlineComponent1_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ColonyList.getInstance().itemArray;
            _local_1 = data.pageN;
            _local_1 = ColonyList.getInstance().colonyNum;
            _local_1 = (!(data.cbean == null));
            _local_1 = data.parent;
            _local_1 = (data.cbean as ColonyBean);
            _local_1 = (data.castle as CastleBean);
        }

        private function _ColonyList_inlineComponent1_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():ArrayCollection
            {
                return (ColonyList.getInstance().itemArray);
            }, function (_arg_1:ArrayCollection):void
            {
                _ColonyList_inlineComponent1_ColonyLogo1.ColonyArr = _arg_1;
            }, "_ColonyList_inlineComponent1_ColonyLogo1.ColonyArr");
            result[0] = binding;
            binding = new Binding(this, function ():int
            {
                return (data.pageN);
            }, function (_arg_1:int):void
            {
                _ColonyList_inlineComponent1_ColonyLogo1.pageN = _arg_1;
            }, "_ColonyList_inlineComponent1_ColonyLogo1.pageN");
            result[1] = binding;
            binding = new Binding(this, function ():int
            {
                return (ColonyList.getInstance().colonyNum);
            }, function (_arg_1:int):void
            {
                _ColonyList_inlineComponent1_ColonyLogo1.colonyNum = _arg_1;
            }, "_ColonyList_inlineComponent1_ColonyLogo1.colonyNum");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(data.cbean == null));
            }, function (_arg_1:Boolean):void
            {
                _ColonyList_inlineComponent1_ColonyLogo1.visible = _arg_1;
            }, "_ColonyList_inlineComponent1_ColonyLogo1.visible");
            result[3] = binding;
            binding = new Binding(this, function ():AllCastleFrame
            {
                return (data.parent);
            }, function (_arg_1:AllCastleFrame):void
            {
                _ColonyList_inlineComponent1_ColonyLogo1.Parent = _arg_1;
            }, "_ColonyList_inlineComponent1_ColonyLogo1.Parent");
            result[4] = binding;
            binding = new Binding(this, function ():ColonyBean
            {
                return (data.cbean as ColonyBean);
            }, function (_arg_1:ColonyBean):void
            {
                _ColonyList_inlineComponent1_ColonyLogo1.LogoColonyBean = _arg_1;
            }, "_ColonyList_inlineComponent1_ColonyLogo1.LogoColonyBean");
            result[5] = binding;
            binding = new Binding(this, function ():CastleBean
            {
                return (data.castle as CastleBean);
            }, function (_arg_1:CastleBean):void
            {
                _ColonyList_inlineComponent1_ColonyLogo1.LogoCastleBean = _arg_1;
            }, "_ColonyList_inlineComponent1_ColonyLogo1.LogoCastleBean");
            result[6] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():ColonyList
        {
            return (this._88844982outerDocument);
        }

        override public function initialize():void
        {
            var target:ColonyList_inlineComponent1;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ColonyList_inlineComponent1_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_ColonyList_inlineComponent1WatcherSetupUtil");
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

        public function set outerDocument(_arg_1:ColonyList):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }


    }
}//package view.castleList

