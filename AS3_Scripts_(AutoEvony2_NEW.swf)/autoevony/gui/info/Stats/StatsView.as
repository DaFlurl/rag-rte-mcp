// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Stats.StatsView

package autoevony.gui.info.Stats
{
    import mx.containers.Canvas;
    import mx.controls.TabBar;
    import mx.containers.ViewStack;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
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

    public class StatsView extends Canvas 
    {

        private var _1423505645statInfoTab:TabBar;
        private var _1220753880heroes:Heroes;
        private var _493567566players:Players;
        private var _180698908alliances:Alliances;
        private var _2105287302statInfoStack:ViewStack;
        private var _1360151735cities:Cities;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "creationPolicy":"none",
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "0";
                            this.right = "0";
                            this.top = "3";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "bottom";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":TabBar,
                                                "id":"statInfoTab",
                                                "stylesFactory":function ():void
                                                {
                                                    this.tabStyleName = "REtabBarTab";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "dataProvider":"statInfoStack",
                                                        "styleName":"REtabBar"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"statInfoStack",
                                    "stylesFactory":function ():void
                                    {
                                        this.borderColor = 0x222222;
                                        this.borderThickness = 1;
                                        this.borderStyle = "solid";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "creationPolicy":"all",
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Players,
                                                "id":"players",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Players",
                                                        "percentHeight":100,
                                                        "percentWidth":100
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Alliances,
                                                "id":"alliances",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Alliances",
                                                        "percentHeight":100,
                                                        "percentWidth":100
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Heroes,
                                                "id":"heroes",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Heroes",
                                                        "percentHeight":100,
                                                        "percentWidth":100
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Cities,
                                                "id":"cities",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Cities",
                                                        "percentHeight":100,
                                                        "percentWidth":100
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]
                });
            }
        });

        public function StatsView()
        {
            mx_internal::_document = this;
            this.creationPolicy = "none";
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        [Bindable(event="propertyChange")]
        public function get statInfoStack():ViewStack
        {
            return (this._2105287302statInfoStack);
        }

        public function toDebugString():String
        {
            return ("fields: players alliances heroes cities");
        }

        [Bindable(event="propertyChange")]
        public function get cities():Cities
        {
            return (this._1360151735cities);
        }

        public function set cities(_arg_1:Cities):void
        {
            var _local_2:Object = this._1360151735cities;
            if (_local_2 !== _arg_1)
            {
                this._1360151735cities = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cities", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get statInfoTab():TabBar
        {
            return (this._1423505645statInfoTab);
        }

        public function set statInfoStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._2105287302statInfoStack;
            if (_local_2 !== _arg_1)
            {
                this._2105287302statInfoStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statInfoStack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get alliances():Alliances
        {
            return (this._180698908alliances);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get heroes():Heroes
        {
            return (this._1220753880heroes);
        }

        public function set players(_arg_1:Players):void
        {
            var _local_2:Object = this._493567566players;
            if (_local_2 !== _arg_1)
            {
                this._493567566players = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "players", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get players():Players
        {
            return (this._493567566players);
        }

        public function set statInfoTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._1423505645statInfoTab;
            if (_local_2 !== _arg_1)
            {
                this._1423505645statInfoTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statInfoTab", _local_2, _arg_1));
            };
        }

        public function set alliances(_arg_1:Alliances):void
        {
            var _local_2:Object = this._180698908alliances;
            if (_local_2 !== _arg_1)
            {
                this._180698908alliances = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alliances", _local_2, _arg_1));
            };
        }

        public function set heroes(_arg_1:Heroes):void
        {
            var _local_2:Object = this._1220753880heroes;
            if (_local_2 !== _arg_1)
            {
                this._1220753880heroes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroes", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.gui.info.Stats

