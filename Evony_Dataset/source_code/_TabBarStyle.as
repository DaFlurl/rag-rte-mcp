// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_TabBarStyle

package 
{
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.core.IFlexModuleFactory;

    public class _TabBarStyle 
    {


        public static function init(fbs:IFlexModuleFactory):void
        {
            var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TabBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TabBar", style, false);
            };
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function ():void
                {
                    this.selectedTabTextStyleName = "activeTabStyle";
                    this.textAlign = "center";
                    this.horizontalAlign = "left";
                    this.verticalAlign = "top";
                    this.verticalGap = -1;
                    this.horizontalGap = -1;
                };
            };
        }


    }
}//package 

