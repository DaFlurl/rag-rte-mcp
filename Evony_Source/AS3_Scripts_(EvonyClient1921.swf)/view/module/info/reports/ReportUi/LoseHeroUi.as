// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.LoseHeroUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.VBox;
    import mx.utils.ObjectProxy;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Form;
    import com.evony.util.UICache;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
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

    public class LoseHeroUi extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _109922450loseHeroContainer:VBox;
        private var _970578998loseHeroListObj:ObjectProxy;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Form,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"loseHeroContainer",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":100});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var uiCache:UICache = new UICache(50);
        private var ac:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function LoseHeroUi()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.addEventListener("creationComplete", ___LoseHeroUi_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            LoseHeroUi._watcherSetupUtil = _arg_1;
        }


        public function set loseHeroObj(_arg_1:ObjectProxy):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            this.loseHeroListObj = _arg_1;
            this.ac.removeAll();
            this.uiCache.reset();
            if ((_arg_1.herounit is ArrayCollection))
            {
                _local_2 = (_arg_1.herounit as ArrayCollection);
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    this.ac.addItem(this.getLoseHeroUI(_local_2[_local_3].heroUrl, _local_2[_local_3].LoseHeroInfo));
                    _local_3++;
                };
            }
            else
            {
                if (_arg_1.herounit != null)
                {
                    this.ac.addItem(this.getLoseHeroUI(_arg_1.herounit.heroUrl, _arg_1.herounit.LoseHeroInfo));
                };
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        [Bindable(event="propertyChange")]
        private function get loseHeroListObj():ObjectProxy
        {
            return (this._970578998loseHeroListObj);
        }

        [Bindable(event="propertyChange")]
        public function get loseHeroContainer():VBox
        {
            return (this._109922450loseHeroContainer);
        }

        private function _LoseHeroUi_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.loseHeroListObj.herounit != null) ? true : false);
            _local_1 = ((this.loseHeroListObj.herounit != null) ? true : false);
        }

        override public function initialize():void
        {
            var target:LoseHeroUi;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _LoseHeroUi_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_LoseHeroUiWatcherSetupUtil");
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

        private function refresh():void
        {
            var _local_1:LoseHeroUnitUi;
            this.loseHeroContainer.removeAllChildren();
            for each (_local_1 in this.ac)
            {
                this.loseHeroContainer.addChild(_local_1);
            };
        }

        private function set loseHeroListObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._970578998loseHeroListObj;
            if (_local_2 !== _arg_1)
            {
                this._970578998loseHeroListObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loseHeroListObj", _local_2, _arg_1));
            };
        }

        public function set loseHeroContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._109922450loseHeroContainer;
            if (_local_2 !== _arg_1)
            {
                this._109922450loseHeroContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loseHeroContainer", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            this.refresh();
        }

        private function _LoseHeroUi_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return ((this.loseHeroListObj.herounit != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                loseHeroContainer.visible = _arg_1;
            }, "loseHeroContainer.visible");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.loseHeroListObj.herounit != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                loseHeroContainer.includeInLayout = _arg_1;
            }, "loseHeroContainer.includeInLayout");
            result[1] = binding;
            return (result);
        }

        private function getLoseHeroUI(_arg_1:String, _arg_2:String):LoseHeroUnitUi
        {
            var _local_3:LoseHeroUnitUi = (uiCache.getUI(LoseHeroUnitUi) as LoseHeroUnitUi);
            _local_3.imgSrc = _arg_1;
            _local_3.loseHeroInfo = _arg_2;
            return (_local_3);
        }

        public function ___LoseHeroUi_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }


    }
}//package view.module.info.reports.ReportUi

