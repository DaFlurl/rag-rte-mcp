// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.ColonieAllHeros

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.beans.ColonyBean;
    import com.evony.common.beans.CastleBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.binding.BindingManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.action.ActionFactory;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.colony.OverviewColonyCastleRespone;
    import com.evony.common.module.colony.ColonyLevyeRespone;
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

    public class ColonieAllHeros extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ColonieAllHeros_DataGrid1:DataGrid;
        public var _ColonieAllHeros_DataGridColumn1:DataGridColumn;
        public var _ColonieAllHeros_DataGridColumn2:DataGridColumn;
        public var _ColonieAllHeros_DataGridColumn3:DataGridColumn;
        public var _ColonieAllHeros_DataGridColumn4:DataGridColumn;
        public var _ColonieAllHeros_DataGridColumn5:DataGridColumn;
        private var _1197684682colonyBean:ColonyBean;
        private var _1825239910currCastleBean:CastleBean;
        private var _113836232castleBean:CastleBean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "2";
                            this.left = "0";
                            this.right = "0";
                            this.verticalAlign = "middle";
                            this.horizontalAlign = "center";
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":290,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_ColonieAllHeros_DataGrid1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "styleName":"style2",
                                            "editable":false,
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "sortableColumns":false,
                                            "columns":[_ColonieAllHeros_DataGridColumn1_i(), _ColonieAllHeros_DataGridColumn2_i(), _ColonieAllHeros_DataGridColumn3_i(), _ColonieAllHeros_DataGridColumn4_i(), _ColonieAllHeros_DataGridColumn5_i()]
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _137063489_herosArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ColonieAllHeros()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.styleName = "baseBackGround";
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___ColonieAllHeros_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonieAllHeros._watcherSetupUtil = _arg_1;
        }


        private function _ColonieAllHeros_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ColonieAllHeros_DataGridColumn1 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_ColonieAllHeros_DataGridColumn1", _ColonieAllHeros_DataGridColumn1);
            return (_local_1);
        }

        private function _ColonieAllHeros_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ColonieAllHeros_DataGridColumn3 = _local_1;
            _local_1.dataField = "management";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_ColonieAllHeros_DataGridColumn3", _ColonieAllHeros_DataGridColumn3);
            return (_local_1);
        }

        private function _ColonieAllHeros_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ColonieAllHeros_DataGridColumn5 = _local_1;
            _local_1.dataField = "stratagem";
            _local_1.width = 90;
            BindingManager.executeBindings(this, "_ColonieAllHeros_DataGridColumn5", _ColonieAllHeros_DataGridColumn5);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:ColonieAllHeros;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ColonieAllHeros_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_ColonieAllHerosWatcherSetupUtil");
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

        private function sowDiscord():void
        {
            ActionFactory.getInstance().getColonyCommands().sowDiscord(castleBean.id, colonyBean.castleId, levyResponse);
        }

        public function set setCastleBean(_arg_1:CastleBean):void
        {
            this.castleBean = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get currCastleBean():CastleBean
        {
            return (this._1825239910currCastleBean);
        }

        public function init():void
        {
        }

        private function set castleBean(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._113836232castleBean;
            if (_local_2 !== _arg_1)
            {
                this._113836232castleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleBean", _local_2, _arg_1));
            };
        }

        private function _ColonieAllHeros_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this._herosArray);
            }, function (_arg_1:Object):void
            {
                _ColonieAllHeros_DataGrid1.dataProvider = _arg_1;
            }, "_ColonieAllHeros_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("将领");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonieAllHeros_DataGridColumn1.headerText = _arg_1;
            }, "_ColonieAllHeros_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonieAllHeros_DataGridColumn2.headerText = _arg_1;
            }, "_ColonieAllHeros_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("内政");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonieAllHeros_DataGridColumn3.headerText = _arg_1;
            }, "_ColonieAllHeros_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("勇武");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonieAllHeros_DataGridColumn4.headerText = _arg_1;
            }, "_ColonieAllHeros_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("智谋");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonieAllHeros_DataGridColumn5.headerText = _arg_1;
            }, "_ColonieAllHeros_DataGridColumn5.headerText");
            result[5] = binding;
            return (result);
        }

        private function set colonyBean(_arg_1:ColonyBean):void
        {
            var _local_2:Object = this._1197684682colonyBean;
            if (_local_2 !== _arg_1)
            {
                this._1197684682colonyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyBean", _local_2, _arg_1));
            };
        }

        private function set currCastleBean(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._1825239910currCastleBean;
            if (_local_2 !== _arg_1)
            {
                this._1825239910currCastleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currCastleBean", _local_2, _arg_1));
            };
        }

        private function getColonyInfo():void
        {
            ActionFactory.getInstance().getColonyCommands().overviewColonialCastle(castleBean.id, this.colonyBean.castleId, setColonyInfo);
        }

        [Bindable(event="propertyChange")]
        private function get _herosArray():ArrayCollection
        {
            return (this._137063489_herosArray);
        }

        [Bindable(event="propertyChange")]
        private function get colonyBean():ColonyBean
        {
            return (this._1197684682colonyBean);
        }

        private function _ColonieAllHeros_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ColonieAllHeros_DataGridColumn2 = _local_1;
            _local_1.dataField = "level";
            _local_1.width = 70;
            BindingManager.executeBindings(this, "_ColonieAllHeros_DataGridColumn2", _ColonieAllHeros_DataGridColumn2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get castleBean():CastleBean
        {
            return (this._113836232castleBean);
        }

        private function _ColonieAllHeros_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ColonieAllHeros_DataGridColumn4 = _local_1;
            _local_1.dataField = "power";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_ColonieAllHeros_DataGridColumn4", _ColonieAllHeros_DataGridColumn4);
            return (_local_1);
        }

        private function setColonyInfo(_arg_1:OverviewColonyCastleRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                currCastleBean = null;
                currCastleBean = _arg_1.castleBean;
                _herosArray = currCastleBean.herosArray;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function levyResponse(_arg_1:ColonyLevyeRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.colonyBean.isCanLevy = false;
                AlertWin.show("You have cast Sow Discord on the city and successfully decreased all heroes' loyalty by some amount in it.");
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg, null);
            };
        }

        private function _ColonieAllHeros_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._herosArray;
            _local_1 = Lang.msg("将领");
            _local_1 = Lang.msg("等级");
            _local_1 = Lang.msg("内政");
            _local_1 = Lang.msg("勇武");
            _local_1 = Lang.msg("智谋");
        }

        public function ___ColonieAllHeros_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set setColony(_arg_1:ColonyBean):void
        {
            this.colonyBean = _arg_1;
        }

        public function set setHeroArray(_arg_1:ArrayCollection):void
        {
            this._herosArray = _arg_1;
        }

        private function set _herosArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._137063489_herosArray;
            if (_local_2 !== _arg_1)
            {
                this._137063489_herosArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_herosArray", _local_2, _arg_1));
            };
        }


    }
}//package view.castleList

