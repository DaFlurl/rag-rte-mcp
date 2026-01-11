// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_EvonyClient_FlexInit

package 
{
    import mx.effects.EffectManager;
    import mx.core.mx_internal;
    import flash.net.getClassByAlias;
    import flash.net.registerClassAlias;
    import mx.collections.ArrayCollection;
    import mx.collections.ArrayList;
    import mx.utils.ObjectProxy;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;
    import flash.utils.*;
    import flash.system.*;

    public class _EvonyClient_FlexInit 
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
            (_local_3.mx_internal::registerEffectTrigger("resizeEndEffect", "resizeEnd"));
            _local_3 = EffectManager;
            (_local_3.mx_internal::registerEffectTrigger("resizeStartEffect", "resizeStart"));
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
                if (getClassByAlias("flex.messaging.io.ObjectProxy") == null)
                {
                    registerClassAlias("flex.messaging.io.ObjectProxy", ObjectProxy);
                };
            }
            catch(e:Error)
            {
                registerClassAlias("flex.messaging.io.ObjectProxy", ObjectProxy);
            };
            var styleNames:Array = ["strokeColor", "fontWeight", "modalTransparencyBlur", "rollOverColor", "textRollOverColor", "verticalGridLineColor", "backgroundDisabledColor", "textIndent", "barColor", "fontSize", "kerning", "footerColors", "textAlign", "disabledIconColor", "fontStyle", "dropdownBorderColor", "modalTransparencyDuration", "textSelectedColor", "strokeWidth", "horizontalGridLineColor", "selectionColor", "modalTransparency", "fontGridFitType", "selectionDisabledColor", "disabledColor", "fontAntiAliasType", "modalTransparencyColor", "alternatingItemColors", "leading", "shadowColor", "iconColor", "dropShadowColor", "themeColor", "indicatorGap", "letterSpacing", "fontFamily", "color", "fontThickness", "labelWidth", "errorColor", "headerColors", "fontSharpness", "textDecoration"];
            var i:int;
            while (i < styleNames.length)
            {
                StyleManager.registerInheritingStyle(styleNames[i]);
                i = (i + 1);
            };
        }


    }
}//package 

