// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.Snippets

package autoevony.gui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.controls.Spacer;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import flash.net.FileReference;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.utils.ByteArray;
    import flash.net.FileFilter;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import flash.net.SharedObject;
    import flash.net.SharedObjectFlushStatus;
    import autoevony.common.Utils;
    import mx.events.PropertyChangeEvent;
    import autoevony.management.CityManager;
    import mx.events.FlexEvent;
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

    public class Snippets extends Canvas implements IBindingClient 
    {

        private static const SAMPLETEXT:String = (("# Define snippet 'sample', to be used with 'include sample' in goal or script" + "\n[sample]") + "\nconfig npc:1");
        private static const DEFAULTTEXT:String = (((("# Define default snippet for new or captured towns or towns with empty goal" + "\n[default]") + "\nconfig comfort:1,trade:0,gate:0.5") + "\ntroop a:200000,warr:1000,wo:1000,p:1000,sw:1000,cav:1000") + "\nfortification ab:1000\n");
        internal static const SETALLGOALS:String = "SetAllGoals";
        internal static const SAVEALLEVENT:String = "SaveAll";
        internal static var isInitialized:Boolean = false;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _892481550status:Text;
        private var _504392816snippetsTextArea:TextArea;
        private var lastSavedFileName:String = null;
        private var LastLoadedFileName:String = null;
        private var snippets:Object = null;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "creationPolicy":"all",
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"snippetsTextArea",
                                    "events":{"change":"__snippetsTextArea_change"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "styleName":"txtAreaStyle"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.verticalAlign = "middle";
                                        this.paddingLeft = 5;
                                        this.paddingRight = 5;
                                        this.paddingTop = 0;
                                        this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":28,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Snippets_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Save File",
                                                        "toolTip":"Save all currently entered Snippets to a text file."
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":5});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Snippets_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Load File",
                                                        "toolTip":"Load Snippets from a text file into the Snippets window."
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":20});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Snippets_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Set Snippets",
                                                        "toolTip":"Activate currently entered Snippets"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":5});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Snippets_Button4_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Save",
                                                        "toolTip":"Save changes to currently entered Snippets"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":15});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Snippets_Button5_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Load",
                                                        "toolTip":"Load last saved Snippets"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":15});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Snippets_Button6_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Save All",
                                                        "toolTip":"Save all Goals, Scripts and Snippets"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":5});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Snippets_Button7_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Set All Goals",
                                                        "toolTip":"Set all Goals for all cities at once"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"status",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "percentWidth":100
                                        });
                                    }
                                })]
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

        public function Snippets()
        {
            mx_internal::_document = this;
            this.creationPolicy = "all";
            this.percentHeight = 100;
            this.percentWidth = 100;
            this.addEventListener("creationComplete", this.___Snippets_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Snippets._watcherSetupUtil = _arg_1;
        }


        public function ___Snippets_Button3_click(_arg_1:MouseEvent):void
        {
            this.setSnippets();
        }

        public function ___Snippets_Button4_click(_arg_1:MouseEvent):void
        {
            this.saveSnippets();
        }

        public function ___Snippets_Button6_click(_arg_1:MouseEvent):void
        {
            this.saveAll();
        }

        public function ___Snippets_Button2_click(_arg_1:MouseEvent):void
        {
            this.onLoadFromFile();
        }

        public function ___Snippets_Button5_click(_arg_1:MouseEvent):void
        {
            this.loadSnippets();
        }

        private function onLoadFromFile():void
        {
            var loadFile:FileReference;
            var selectedHandler:Function;
            var canceledHandler:Function;
            var completeHandler:Function;
            var errorHandler:Function;
            loadFile = null;
            selectedHandler = function (_arg_1:Event):void
            {
                loadFile.removeEventListener(Event.SELECT, selectedHandler);
                loadFile.removeEventListener(Event.CANCEL, canceledHandler);
                loadFile.addEventListener(Event.COMPLETE, completeHandler);
                loadFile.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                loadFile.load();
            };
            canceledHandler = function (_arg_1:Event):void
            {
                loadFile.removeEventListener(Event.SELECT, selectedHandler);
                loadFile.removeEventListener(Event.CANCEL, canceledHandler);
                if (Version.isTraceOn())
                {
                    trace(("The file load has been canceled. " + _arg_1));
                };
                loadFile = null;
            };
            completeHandler = function (_arg_1:Event):void
            {
                loadFile.removeEventListener(Event.COMPLETE, completeHandler);
                loadFile.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                var _local_2:ByteArray = loadFile.data;
                LastLoadedFileName = loadFile.name;
                updateTarget(_local_2.readUTFBytes(_local_2.bytesAvailable).replace(/\r\n?|\n/g, "\n"));
                status.text = (('The contents of file "' + loadFile.name) + '" was successfully loaded to the snippets window.');
                loadFile = null;
            };
            errorHandler = function (_arg_1:IOErrorEvent):void
            {
                loadFile.removeEventListener(Event.COMPLETE, completeHandler);
                loadFile.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                if (Version.isTraceOn())
                {
                    trace(("Error loading file : " + _arg_1.text));
                };
                status.text = ("An error occured while loading the file. " + _arg_1);
                loadFile = null;
            };
            loadFile = new FileReference();
            loadFile.addEventListener(Event.SELECT, selectedHandler);
            loadFile.addEventListener(Event.CANCEL, canceledHandler);
            loadFile.browse([new FileFilter("Text File", "*.txt;*.text")]);
        }

        private function _Snippets_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = "";
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                status.text = _arg_1;
            }, "status.text");
            result[0] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:Snippets;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._Snippets_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_SnippetsWatcherSetupUtil");
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

        private function saveSnippets(_arg_1:Boolean=false):void
        {
            if (this.snippetsTextArea == null)
            {
                return;
            };
            var _local_2:SharedObject = SharedObject.getLocal("snippets");
            _local_2.data.now = this.snippetsTextArea.text;
            if (_local_2.flush() != SharedObjectFlushStatus.FLUSHED)
            {
                this.status.text = (("SAVING PROBLEM: " + this.status) + ", you may need to increase flash local storage");
            }
            else
            {
                if (!_arg_1)
                {
                    this.status.text = "Snippets have been saved successfully";
                };
            };
        }

        public function getTrimmedSnippetCmdLines(_arg_1:Array, _arg_2:int=20, _arg_3:int=10000):Array
        {
            var _local_4:String;
            var _local_5:String;
            var _local_6:Array;
            var _local_7:String;
            var _local_8:Array = new Array();
            var _local_9:int;
            while (_local_9 < _arg_1.length)
            {
                _local_4 = Utils.trim(_arg_1[_local_9]);
                if (((_local_4.substr(0, 11) == "includeurl ") || (_local_4.substr(0, 12) == "includefile ")))
                {
                    _local_8.push(_local_4);
                }
                else
                {
                    if (_local_4.indexOf("//") != -1)
                    {
                        _local_4 = Utils.trim(_local_4.substr(0, _local_4.indexOf("//")));
                    };
                    if (!((_local_4.length == 0) || (_local_4.charAt(0) == "#")))
                    {
                        if (_local_4 != "include")
                        {
                            if (_local_4.substr(0, 8) == "include ")
                            {
                                if (_arg_2 <= 0)
                                {
                                    this.status.text = "ERROR: Too many recursions in snippets";
                                    return (null);
                                };
                                _local_5 = _local_4.substr(8).toLowerCase();
                                if (this.snippets[_local_5] == undefined)
                                {
                                    this.status.text = (("ERROR: no snippet '" + _local_5) + "' found");
                                    return (null);
                                };
                                _local_6 = this.getTrimmedSnippetCmdLines(this.snippets[_local_5], (_arg_2 - 1), _arg_3);
                                if (_local_6 == null)
                                {
                                    this.status.text = (("ERROR: processing snippet '" + _local_5) + "'");
                                    return (null);
                                };
                                if (_local_6.length > _arg_3)
                                {
                                    this.status.text = (((("ERROR: snippet " + _local_5) + " is too large. It has more than ") + _arg_3) + " lines");
                                    return (null);
                                };
                                for each (_local_7 in _local_6)
                                {
                                    _local_8.push(_local_7);
                                };
                            }
                            else
                            {
                                _local_8.push(_local_4);
                            };
                        };
                    };
                };
                _local_9++;
            };
            return (_local_8);
        }

        public function init():void
        {
            this.loadSnippets();
            this.setSnippets();
            isInitialized = true;
        }

        public function ___Snippets_Button7_click(_arg_1:MouseEvent):void
        {
            this.setAllGoals();
        }

        public function set snippetsTextArea(_arg_1:TextArea):void
        {
            var _local_2:Object = this._504392816snippetsTextArea;
            if (_local_2 !== _arg_1)
            {
                this._504392816snippetsTextArea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "snippetsTextArea", _local_2, _arg_1));
            };
        }

        private function setAllGoals(_arg_1:Object=null):void
        {
            parentDocument.dispatchEvent(new Event(SETALLGOALS));
            this.status.text = "All goals have been set";
        }

        private function _Snippets_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = "";
        }

        internal function saveAll(_arg_1:Object=null):void
        {
            if (_arg_1 == null)
            {
                this.status.text = "Save all goals and scripts and various internal data";
                CityManager.cleanUpAndFlushAllTimingLists();
                parentDocument.dispatchEvent(new Event(SAVEALLEVENT));
            }
            else
            {
                this.saveSnippets(true);
            };
        }

        public function ___Snippets_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        public function set status(_arg_1:Text):void
        {
            var _local_2:Object = this._892481550status;
            if (_local_2 !== _arg_1)
            {
                this._892481550status = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _local_2, _arg_1));
            };
        }

        private function formatTextArea():void
        {
            this.snippetsTextArea.setStyle("color", "#FFFFFF");
            this.snippetsTextArea.setStyle("fontFamily", "DejaVu Sans");
        }

        [Bindable(event="propertyChange")]
        public function get status():Text
        {
            return (this._892481550status);
        }

        private function onSaveToFile():void
        {
            var saveFile:FileReference;
            var canceledHandler:Function;
            var errorHandler:Function;
            if (((this.snippetsTextArea == null) || (this.snippetsTextArea.text == "")))
            {
                return;
            };
            var outputText:String = this.snippetsTextArea.text.replace(/\r\n?|\n/g, "\r\n");
            var outputFileName:String = "";
            saveFile = null;
            if (((!(this.lastSavedFileName == null)) && (!(this.lastSavedFileName == ""))))
            {
                outputFileName = this.lastSavedFileName;
            }
            else
            {
                if (((!(this.LastLoadedFileName == null)) && (!(this.LastLoadedFileName == ""))))
                {
                    outputFileName = this.LastLoadedFileName;
                }
                else
                {
                    outputFileName = (MainScreen.getPlayer().playerInfo.userName + "_snippets.txt");
                };
            };
            saveFile = new FileReference();
            var completedHandler:Function = function (_arg_1:Event):void
            {
                saveFile.removeEventListener(Event.COMPLETE, removeEventListener);
                saveFile.removeEventListener(Event.CANCEL, canceledHandler);
                saveFile.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                lastSavedFileName = saveFile.name;
                status.text = (('The file "' + saveFile.name) + '" has been saved successfully.');
                saveFile = null;
                if (Version.isTraceOn())
                {
                    trace(("The Snippets file has been saved successfully. " + _arg_1));
                };
            };
            canceledHandler = function (_arg_1:Event):void
            {
                saveFile.removeEventListener(Event.COMPLETE, removeEventListener);
                saveFile.removeEventListener(Event.CANCEL, canceledHandler);
                saveFile.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                saveFile = null;
                if (Version.isTraceOn())
                {
                    trace(("The Snippets file save has been canceled. " + _arg_1));
                };
            };
            errorHandler = function (_arg_1:IOErrorEvent):void
            {
                saveFile.removeEventListener(Event.COMPLETE, removeEventListener);
                saveFile.removeEventListener(Event.CANCEL, canceledHandler);
                saveFile.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                saveFile = null;
                if (Version.isTraceOn())
                {
                    trace(("An error occured while saving the Snippets file. " + _arg_1));
                };
            };
            try
            {
                saveFile.addEventListener(Event.COMPLETE, completedHandler);
                saveFile.addEventListener(Event.CANCEL, canceledHandler);
                saveFile.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                saveFile.save(outputText, outputFileName);
            }
            catch(error:Error)
            {
                this.status.text = error;
            };
        }

        [Bindable(event="propertyChange")]
        public function get snippetsTextArea():TextArea
        {
            return (this._504392816snippetsTextArea);
        }

        private function setSnippets(_arg_1:Boolean=false):void
        {
            var _local_7:String;
            var _local_2:Array = this.snippetsTextArea.text.split(new RegExp("\r|\n"));
            var _local_3:Object = new Object();
            var _local_4:String;
            var _local_5:Array = new Array();
            var _local_6:Array = new Array();
            for each (_local_7 in _local_2)
            {
                _local_7 = Utils.trim(_local_7);
                if (((_local_7.charAt(0) == "[") && (_local_7.charAt((_local_7.length - 1)) == "]")))
                {
                    if (_local_4 != null)
                    {
                        _local_6.push(_local_4);
                        _local_3[_local_4] = _local_5;
                    };
                    _local_4 = _local_7.substr(1, (_local_7.length - 2)).toLowerCase();
                    _local_5 = new Array();
                }
                else
                {
                    _local_5.push(_local_7);
                };
            };
            if (_local_4 != null)
            {
                _local_3[_local_4] = _local_5;
                _local_6.push(_local_4);
            };
            this.snippets = _local_3;
            if (_local_3["default"] == undefined)
            {
                if (_arg_1)
                {
                    this.status.text = "WARNING: [default] snippet is not defined, !!!";
                }
                else
                {
                    this.snippetsTextArea.text = ((DEFAULTTEXT + "\n") + this.snippetsTextArea.text);
                    this.setSnippets(true);
                };
            }
            else
            {
                if (_local_6.length > 0)
                {
                    this.status.text = ("Snippet(s) found: " + _local_6.join(" "));
                };
            };
        }

        private function updateTarget(_arg_1:String):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            this.snippetsTextArea.text = _arg_1;
        }

        private function loadSnippets(_arg_1:Object=null):void
        {
            var _local_2:SharedObject;
            if (this.snippetsTextArea == null)
            {
                Utils.callLater(50, this.loadSnippets);
            }
            else
            {
                _local_2 = SharedObject.getLocal("snippets");
                this.snippetsTextArea.text = _local_2.data.now;
                if (this.snippetsTextArea.text == "")
                {
                    this.snippetsTextArea.text = ((DEFAULTTEXT + "\n") + SAMPLETEXT);
                };
            };
        }

        public function ___Snippets_Button1_click(_arg_1:MouseEvent):void
        {
            this.onSaveToFile();
        }

        public function __snippetsTextArea_change(_arg_1:Event):void
        {
            this.formatTextArea();
        }


    }
}//package autoevony.gui

