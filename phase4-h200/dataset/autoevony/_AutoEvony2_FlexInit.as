// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_AutoEvony2_FlexInit

package 
{
    import mx.effects.EffectManager;
    import mx.core.mx_internal;
    import flash.net.getClassByAlias;
    import flash.net.registerClassAlias;
    import mx.collections.ArrayCollection;
    import mx.collections.ArrayList;
    import mx.messaging.config.ConfigMap;
    import mx.messaging.messages.AcknowledgeMessage;
    import mx.messaging.messages.AcknowledgeMessageExt;
    import mx.messaging.messages.AsyncMessage;
    import mx.messaging.messages.AsyncMessageExt;
    import mx.messaging.messages.CommandMessage;
    import mx.messaging.messages.CommandMessageExt;
    import mx.messaging.messages.ErrorMessage;
    import mx.messaging.messages.HTTPRequestMessage;
    import mx.messaging.messages.MessagePerformanceInfo;
    import mx.utils.ObjectProxy;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;
    import flash.utils.*;
    import flash.system.*;

    public class _AutoEvony2_FlexInit 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var _local_3:* = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("addedEffect", "added"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("completeEffect", "complete"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("creationCompleteEffect", "creationComplete"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("focusInEffect", "focusIn"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("focusOutEffect", "focusOut"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("hideEffect", "hide"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("itemsChangeEffect", "itemsChange"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("mouseDownEffect", "mouseDown"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("mouseUpEffect", "mouseUp"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("moveEffect", "move"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("removedEffect", "removed"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("resizeEffect", "resize"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("rollOutEffect", "rollOut"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("rollOverEffect", "rollOver"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("showEffect", "show"));
            try
            {
                if (getClassByAlias("flex.messaging.io.ArrayCollection") == null)
                {
                    registerClassAlias("flex.messaging.io.ArrayCollection", ArrayCollection);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.io.ArrayCollection", ArrayCollection);
            };
            try
            {
                if (getClassByAlias("flex.messaging.io.ArrayList") == null)
                {
                    registerClassAlias("flex.messaging.io.ArrayList", ArrayList);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.io.ArrayList", ArrayList);
            };
            try
            {
                if (getClassByAlias("flex.messaging.config.ConfigMap") == null)
                {
                    registerClassAlias("flex.messaging.config.ConfigMap", ConfigMap);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.config.ConfigMap", ConfigMap);
            };
            try
            {
                if (getClassByAlias("flex.messaging.messages.AcknowledgeMessage") == null)
                {
                    registerClassAlias("flex.messaging.messages.AcknowledgeMessage", AcknowledgeMessage);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.messages.AcknowledgeMessage", AcknowledgeMessage);
            };
            try
            {
                if (getClassByAlias("DSK") == null)
                {
                    registerClassAlias("DSK", AcknowledgeMessageExt);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("DSK", AcknowledgeMessageExt);
            };
            try
            {
                if (getClassByAlias("flex.messaging.messages.AsyncMessage") == null)
                {
                    registerClassAlias("flex.messaging.messages.AsyncMessage", AsyncMessage);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.messages.AsyncMessage", AsyncMessage);
            };
            try
            {
                if (getClassByAlias("DSA") == null)
                {
                    registerClassAlias("DSA", AsyncMessageExt);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("DSA", AsyncMessageExt);
            };
            try
            {
                if (getClassByAlias("flex.messaging.messages.CommandMessage") == null)
                {
                    registerClassAlias("flex.messaging.messages.CommandMessage", CommandMessage);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.messages.CommandMessage", CommandMessage);
            };
            try
            {
                if (getClassByAlias("DSC") == null)
                {
                    registerClassAlias("DSC", CommandMessageExt);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("DSC", CommandMessageExt);
            };
            try
            {
                if (getClassByAlias("flex.messaging.messages.ErrorMessage") == null)
                {
                    registerClassAlias("flex.messaging.messages.ErrorMessage", ErrorMessage);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.messages.ErrorMessage", ErrorMessage);
            };
            try
            {
                if (getClassByAlias("flex.messaging.messages.HTTPMessage") == null)
                {
                    registerClassAlias("flex.messaging.messages.HTTPMessage", HTTPRequestMessage);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.messages.HTTPMessage", HTTPRequestMessage);
            };
            try
            {
                if (getClassByAlias("flex.messaging.messages.MessagePerformanceInfo") == null)
                {
                    registerClassAlias("flex.messaging.messages.MessagePerformanceInfo", MessagePerformanceInfo);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.messages.MessagePerformanceInfo", MessagePerformanceInfo);
            };
            try
            {
                if (getClassByAlias("flex.messaging.io.ObjectProxy") == null)
                {
                    registerClassAlias("flex.messaging.io.ObjectProxy", ObjectProxy);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.io.ObjectProxy", ObjectProxy);
            };
            var styleNames:Array = ["fontAntiAliasType", "errorColor", "horizontalGridLineColor", "kerning", "backgroundDisabledColor", "iconColor", "modalTransparencyColor", "textRollOverColor", "textIndent", "verticalGridLineColor", "themeColor", "modalTransparency", "textDecoration", "dividerColor", "headerColors", "fontThickness", "textAlign", "fontFamily", "textSelectedColor", "selectionDisabledColor", "labelWidth", "fontGridFitType", "letterSpacing", "rollOverColor", "fontStyle", "dropShadowColor", "fontSize", "selectionColor", "disabledColor", "dropdownBorderColor", "indicatorGap", "fontWeight", "disabledIconColor", "modalTransparencyBlur", "leading", "color", "alternatingItemColors", "fontSharpness", "barColor", "modalTransparencyDuration"];
            var i:int;
            while (i < styleNames.length)
            {
                StyleManager.registerInheritingStyle(styleNames[i]);
                i = (i + 1);
            };
        }


    }
}//package 

