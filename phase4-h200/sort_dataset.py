#!/usr/bin/env python3
"""
Evony Dataset Sorter - Phase 4 (Fixed)
Sorts files into KEEP (Evony-related) vs TRASH (non-Evony junk)
"""

import os
import shutil
from pathlib import Path
from typing import Set, List, Tuple

# Base paths
BASE_DIR = Path(r"C:\Users\Admin\Downloads\Evony_Decrypted\phase4-h200\dataset")
TRASH_DIR = BASE_DIR / "trash"

# ============================================================================
# TRASH PATTERNS - Files that are NOT Evony-related
# ============================================================================

# Virus group documentation filenames (exact matches or patterns)
VIRUS_GROUP_DOCS = {
    "29A.md", "3C_Group_Cyber_Criminals_Clan.md", "Anarkick_Systems.md", "ANVX.md",
    "ARCV_Association_of_Really_Cruel_Viruses.md", "ASM_Association_of_Satanic_Maniacs.md",
    "Astigmatizm.md", "Australian_Institute_of_Hackers.md", 
    "AVCR_Amateur_Virus_Creation_Research_Group.md", "AVM_Alternative_Virus_Mafia.md",
    "A_N_O_I_A_New_Order_of_Intelligence.md", "BHA_Badsector_Hacking_Alliance.md",
    "Brigada_Ocho.md", "BzZ.md", "Computa_GangstaZ.md", "CVC_Corean_Virus_Club_new.md",
    "CVC_Corean_Virus_Club_old.md", "CVL_Corean_Virus_Laboratory.md", "Cybernetic_Crew.md",
    "DAN_Digital_Anarchy.md", "Darkness_Sons.md", "Dark_Conspiracy.md", 
    "DDT_(Dichlore_Diphenyl_Trichloretane).md", "Demoralized_Youth.md", 
    "Diabolical_Kreations.md", "Diffusion.md", "Divide_By_Zero.md", "Doom_Riderz.md",
    "DVC_Death_Virii_Crew.md", "DVC_Dutch_Virii_Community.md", "Familia.md",
    "FCF_Fearless_Criminal_Force_Formaters_Cracking_Force.md", "FS_Feathered_Serpents.md",
    "Gedzac.md", "Genesis.md", "Hackerz_Networx.md", "Hail_and_Kill.md", "HCDS.md",
    "HTC_95.md", "HVM_Hungarian_Virus_Acade_my.md", "IKX_International_Knowledge_eXchange.md",
    "Immortal_EAS.md", "Immortal_Riot.md", "Intergang.md", "Invaders.md",
    "IR_G_Immortal_Riot_Genesis.md", "Italian_Virus_Research_Laboratory.md",
    "Team_Necrosis.md", "VLAD_Virus_Laboratory_And_Distribution.md",
    # From keys folder
    "DIVA_Digital_Indonesian_Vx_Authors.md", "Electrical_Ordered_Freedom.md",
    "Hazard.md", "JVS_Janus_Virus_Syndicate.md", "K_P_V_Team.md", "LineZer0_VX_Team.md",
    "Living_Turmoil.md", "LT_RSA_Living_Turmoil_Ruthless_Stealth_Angels.md",
    "Mandragora.md", "Matrix.md", "Metaphase_VX_Team.md", "Mikees_World.md",
    "Misdirected_Youth.md", "NoP.md", "No_Mercy.md", "NuKE.md", "Phalcon-Skism.md",
    "Power_Empire_Virii_Faction.md", "Power_Heap_Research.md", "PVW_Pinoy_Virus_Writers.md",
    "Rabid.md", "Ready_Rangers_Liberation_Front.md", "Rioters.md", 
    "RSA_Ruthless_Stealth_Angels.md", "RVM_Russian_Virus_Makers.md",
    "Sector_Infector_Inc.md", "SG_Stealth_Group_former_SG_World_Wide.md",
    "ShadowVX_Group.md", "Shadow_Dancer_Team.md", "Silicium_Revolte.md",
    "Skamwerk_Labs.md", "SLAM.md", "SMF.md", "SOS_Sign_Of_Scream.md",
    "SPS_Scientific_Programming_Society.md", "SVAT_Special_Viruses_And_Trojans.md",
    "SVL_Slovak_Virus_Laboratories.md", "SVS_Seoul_Virus_Society.md",
    "TAVC_Tula_Anti_Viral_Club.md", "TDJ_The_Diabolical_Judges.md",
    "The_Codebreakers.md", "The_Kefrens.md", "The_Trinity.md", "TI_Technological_Illusions.md",
    "TNN_The_Narkotic_Network.md", "TPVO_OVEL_Taiwan_Power_Virus_Organisation_Organization_of_Virus_Examination_Lab.md",
    "TridenT.md", "Trinity.md", "UCSI_Ultimate_Chaos_Security_International.md",
    "V-Zone_Virus_Zone.md", "VBB_Virus_Bits_Bytes.md",
    "VDV_Verband_Deutscher_Virenliebhaber_The_German_Association_Of_Virus_Lovers.md",
    "Viper_Viral_Inclined_Programming_Experts_Group.md", "ViroGenic_Junkies.md",
    "Virulent_Graffiti.md", "VOFCA_Virus_and_Other_Fine_Code_Authors.md",
    "VXI_VX_India.md", "WAVE_World_Association_of_Virus_Enhancement.md",
    "Youths_Against_McAfee.md", "ZeroGravity.md",
    "DV_Verband_Deutscher_Virenliebhaber_The_German_Association_of_Virus_Lovers.md",
}

# License files (trash)
LICENSE_EXACT = {
    "Apache_License_2.0.txt", "Apache_License_2.0_with_LLVM_Exceptions.txt",
    "APACHE-ANT.txt", "APACHE-RESOLVER.txt", "APACHE-XERCES.txt",
    "BSD.txt", "BSD-2-ATLASSIAN.txt", "BSD-2-ORACLE.txt", "BSD-3-APPLE.txt",
    "BSD-3-CAPSTONE.txt", "BSD-3-GOOGLE.txt", "BSD-3-GRUVER.txt", "BSD-3-HAMCREST.txt",
    "BSD-3-JUNG.txt", "BSD-3-ORACLE.txt", "BSD-3-PARR-HARWELL.txt", "BSD-3-PSUTIL.txt",
    "GPL+CLASSPATH.txt", "GPLv3.txt", "GPL_2.txt", "GPL_2_With_Classpath_Exception.txt",
    "GPL_3_Linking_Permitted.txt", "LGPL_2.1.txt", "MIT.txt", "OFL.txt", "OFL_1.txt",
    "LEGAL.txt", "Public_Domain.txt", "CERN.txt", "CERN_1.txt", "THAI.txt",
    "UNICODE.txt", "UNICODE_1.txt", "FRIJTERS.txt", "INRIA_License.txt", "JAMESCLARK.txt",
    "Bouncy_Castle_License.txt", "JDOM_License.txt", "JSch_License.txt", "Jython_License.txt",
    "PostgresqlJDBC_License.txt", "Postgresql_License.txt", "Python_Software_Foundation_License.txt",
    "Crystal_Clear_Icons_-_LGPL_2.1.txt", "FAMFAMFAM_Icons_-_CC_2.5.txt",
    "FAMFAMFAM_Mini_Icons_-_Public_Domain.txt", "Modified_Nuvola_Icons_-_LGPL_2.1.txt",
    "Nuvola_Icons_-_LGPL_2.1.txt", "Oxygen_Icons_-_LGPL_3.0.txt", "Tango_Icons_-_Public_Domain.txt",
    "java_cup.LICENSE.txt", "java_cup.README.txt", "runtime.LICENSE.txt", "runtime.README.txt",
    "regexp.README.txt", "yajsw.policy.txt", "commons-collections-LICENSE.txt",
    "commons-logging-NOTICE.txt", "OtherLicenses.txt", "CREDITS.txt",
    "LICENSE.dom-documentation.txt", "LICENSE.dom-software.txt", "LICENSE.sax.txt",
    "README.dom.txt", "README.sax.txt", "README.xml-apis-ext.txt",
    "NOTICE.serializer.txt", "BCEL.LICENSE.txt", "BCEL.README.txt",
    "avi.montemedia.license.txt", "decimal.license.txt", "ffdec_lib.license.txt",
    "flacomdoc.license.txt", "flamingo.license.txt", "gif.license.txt", "gifreader.license.txt",
    "jlayer.license.txt", "jna.license.txt", "jpacker.license.txt", "jsyntaxpane.license.txt",
    "minimal-json.license.txt", "miterstroke.license.txt", "nellymoser.license.txt",
    "sfntly.license.txt", "substance.license.txt", "substance-flamingo.license.txt",
    "tga.license.txt", "trident.license.txt", "ttf.doubletype.license.txt",
    "ttf.fontastic.license.txt", "zlib_License.txt", "easing_readme.txt",
    "Public_Domain_a06dc84c.txt",
}

# Ghidra pattern files (all those *_patterns.xml)
GHIDRA_PATTERNS = {
    "68000_patterns.xml", "aarch64-pltThunks.xml", "AARCH64_LE_patterns.xml",
    "AARCH64_win_patterns.xml", "ARM_BE_patterns.xml", "ARM_LE_patterns.xml",
    "ARM_switch_patterns.xml", "AVR8_patterns.xml", "loongarch_patterns.xml",
    "MIPS_BE_patterns.xml", "MIPS_LE_patterns.xml", "pa-risc_patterns.xml",
    "ppc64-r2CallStubs.xml", "PPC_BE_patterns.xml", "PPC_LE_patterns.xml",
    "SPARC_patterns.xml", "SuperH4_patterns.xml", "tricore_patterns.xml",
    "V850_patterns.xml", "x86-16_default_patterns.xml", "x86-64gcc_patterns.xml",
    "x86delphi_patterns.xml", "x86gcc_patterns.xml", "x86win_patterns.xml",
    "x86win_prepatterns.xml", "xtensa_patterns.xml",
}

# Ghidra tutorial/doc files
GHIDRA_DOCS = {
    "A1-GettingStarted.md", "A2-UITour.md", "A3-Breakpoints.md", "A4-MachineState.md",
    "A5-Navigation.md", "A6-MemoryMap.md", "B1-RemoteTargets.md", "B2-Emulation.md",
    "B3-Scripting.md", "B4-Modeling.md", "BSimTutorial_Intro.md", "BSimTutorial_Basic_Queries.md",
    "BSimTutorial_BSim_Command_Line.md", "BSimTutorial_Creating_Database_From_GUI.md",
    "BSimTutorial_Enabling.md", "BSimTutorial_Evaluating_Matches.md", "BSimTutorial_Exe_Results.md",
    "BSimTutorial_Filters.md", "BSimTutorial_Ghidra_Command_Line.md", "BSimTutorial_Overview_Queries.md",
    "BSimTutorial_Scripting.md",
}

# Ghidra batch files
GHIDRA_BATCHES = {
    "ghidraRun.bat", "ghidraDebug.bat", "ghidraClean.bat", "ghidraGo.bat",
    "ghidraSvr.bat", "svrAdmin.bat", "jythonRun.bat", "jshellRun.bat",
    "pyghidraRun.bat", "bsim.bat", "sleigh.bat", "analyzeHeadless.bat",
    "convertStorage.bat", "createPdbXmlFiles.bat", "dbgengGADPServerRun.bat",
    "dbgmodelGADPServerRun.bat", "kernel-dbgeng.bat", "local-dbgeng.bat",
    "local-dbgeng-attach.bat", "local-dbgeng-ext.bat", "local-gdb.bat",
    "local-lldb.bat", "local-ttd.bat", "remote-dbgeng.bat", "remote-gdb.bat",
    "ssh-gdb.bat", "ssh-gdbserver.bat", "qemu-sys-gdb.bat",
}

# Ghidra Python scripts
GHIDRA_PYTHON = {
    "AddCommentToProgramScriptPy.py", "AskScriptPy.py", "ChooseDataTypeScriptPy.py",
    "ExampleColorScriptPy.py", "FormatExampleScriptPy.py", "ToolPropertiesExampleScriptPy.py",
}

# Ghidra XML configs
GHIDRA_XMLS = {
    "gdb_syntax.xml", "sleigh_syntax.xml", "GhidraEclipseFormatter.xml",
    "GhidraCDTFormatter.xml", "sleighArgs.txt", "functionTags.xml",
    "noReturnFunctionConstraints.xml", "FileBitPatternInfoReaderTestFile1.xml",
}

# Decompiler XML fragments
DECOMPILER_XMLS = {
    "deadvolatile.xml", "deindirect.xml", "deindirect2.xml", "divopt.xml",
    "doublemove.xml", "dupptr.xml", "elseif.xml", "enum.xml", "floatcast.xml",
    "floatconv.xml", "floatprint.xml", "heapstring.xml", "ifswitch.xml",
    "impliedfield.xml", "indproto.xml", "injectoverride.xml", "inline.xml",
    "longdouble.xml", "loopcomment.xml", "lzcount.xml", "mixfloatint.xml",
    "modulo.xml", "modulo2.xml", "multiret.xml", "nan.xml", "nestedoffset.xml",
    "offsetarray.xml", "orcompare.xml", "packstructaccess.xml",
    "partialmerge.xml", "partialsplit.xml", "partialunion.xml", "piecestruct.xml",
    "pointercmp.xml", "pointerrel.xml", "pointersub.xml", "probe_fixup.xml",
    "promotecompare.xml", "ptrtoarray.xml", "readvolatile.xml", "retspecial.xml",
    "retstruct.xml", "revisit.xml", "sbyte.xml", "skipnext2.xml", "stackreturn.xml",
    "stackstring.xml", "statuscmp.xml", "switchhide.xml", "switchind.xml",
    "switchloop.xml", "switchmulti.xml", "switchreturn.xml", "threedim.xml",
    "try_fixup.xml", "try_fixup_1.xml", "twodim.xml", "union_datatype.xml",
    "varcross.xml", "wayoffarray.xml", "boolless.xml", "cc.xml", "ccmp.xml",
    "concat.xml", "condconst.xml", "condmulti.xml", "convert.xml", "gp.xml",
    # Forloop patterns
    "forloop1.xml", "forloop_loaditer.xml", "forloop_thruspecial.xml",
    "forloop_varused.xml", "forloop_withskip.xml", "noforloop_alias.xml",
    "noforloop_globcall.xml", "noforloop_iterused.xml",
    # Weight files
    "large_32.xml", "medium_32.xml", "medium_64.xml", "medium_cpool.xml",
    "medium_nosize.xml", "lshweights_32.xml", "lshweights_64.xml",
    "lshweights_64_32.xml", "lshweights_cpool.xml", "lshweights_nosize.xml",
    # Other
    "patternconstraints.xml", "prepatternconstraints.xml",
}

# Flex SDK batch files
FLEX_BATCHES = {
    "asdoc.bat", "acompc.bat", "amxmlc.bat", "asc.bat", "aasdoc.bat",
    "compc.bat", "compile.bat", "fcsh.bat", "fdb.bat", "fontswf.bat",
    "mxmlc.bat", "optimizer.bat", "swcdepends.bat", "swfdump.bat",
    "checkAllPlayerGlobals.bat", "copylocale.bat", "digest.bat",
}

# Flex SDK XML configs
FLEX_XMLS = {
    "flex-config.xml", "flex-config-template.xml", "air-config.xml", "air-config-template.xml",
    "airmobile-config.xml", "airmobile-config-template.xml", "framework-config.xml",
    "apache-flex-sdk-installer-config.xml", "apache-manifest.xml", "experimental-manifest.xml",
    "experimental-mobile-manifest.xml", "mx-manifest.xml", "mxml-manifest.xml",
    "mxml-2009-manifest.xml", "spark-manifest.xml", "design.xml", "installer.xml",
    "serverconfig.xml", "services-config.xml", "flex-sdk-description.xml",
    "ASDoc_Config_Base.xml", "ASDoc_terms.xml", "Overviews_Base.xml",
    "manifest_advancedgrids.xml", "manifest_automation.xml", "manifest_automation_air.xml",
    "manifest_automation_airspark.xml", "manifest_automation_dmv.xml",
    "manifest_automation_spark.xml", "manifest_charts.xml", "manifest_spark_dmv.xml",
    "TOC_Source.xml",
}

# Bundle configs (numbered)
def is_bundle_or_compile_config(filename):
    return (filename.startswith("bundle-config") or 
            filename.startswith("compile-config") or
            filename.startswith("spark-manifest_") or
            filename.startswith("manifest_"))

# dnSpy configs
DNSPY_FILES = set()  # Will match by pattern

def is_dnspy_file(filename):
    return filename.startswith("dnSpy.")

# Web/JS junk
WEB_JUNK = {
    "jquery-3.7.1.min.js", "jquery-ui.min.js", "mootools.js", "swfobject.js",
    "FABridge.js", "FABridgeSample.js", "cookies.js", "history.js", "help.js",
    "search.js", "search-page.js", "sprite.js", "store.js", "script.js",
    "index.js", "AC_OETags.js", "asdoc.js", "module-search-index.js",
    "package-search-index.js", "tag-search-index.js", "type-search-index.js",
    "jquery.md", "jqueryUI.md",
}

# Style AS files (Flex SDK artifacts, not Evony source)
FLEX_STYLE_FILES = {
    "AdvancedInheritingTextStyles.as", "AdvancedNonInheritingTextStyles.as",
    "AlignStyles.as", "AnchorStyles.as", "BackgroundStyles.as", "BarColorStyle.as",
    "BasicInheritingTextStyles.as", "BasicNonInheritingTextStyles.as",
    "ContainerBackgroundStyles.as", "ContainerBackgroundStyles_1.as",
    "FillStrokeStyles.as", "FillStyles.as", "FocusStyles.as", "FocusStyles_1.as",
    "GapStyles.as", "GapStyles_1.as", "GapStyles_2.as", "GapStyles_3.as",
    "LeadingStyle.as", "LeadingStyle_1.as", "MarginStyles.as",
    "ModalTransparencyStyles.as", "PaddingStyles.as", "PaddingStyles_1.as",
    "SelectedFillColorsStyle.as", "SelectionFormatTextStyles.as", "SkinStyles.as",
    "TextStyles.as", "TextStyles_1.as",
    # Interfaces
    "IAbstractEffect.as", "IAbstractEffect_1.as", "IBindingClient.as",
    "IBindingClient_1.as", "IBindingClient_2.as", "IExternalData.as",
    "IFlexAsset.as", "IFlexAsset_1.as", "IListItemRenderer.as", "IListItemRenderer_1.as",
    "IOLAPAttribute.as", "IPropertyChangeNotifier.as", "IPropertyChangeNotifier_1.as",
    "IToggleButton.as", "IToggleButton_1.as", "IToggleButton_2.as",
    "object_proxy.as", "object_proxy_1.as", "mx_internal.as",
}

# PowerShell scripts for other tools
PS_OTHER_TOOLS = {
    "Find-AllConfigSol.ps1", "Install-AllTools.ps1", "Restart-AllTor.ps1",
    "Update-Tor.ps1", "Verify-TorSetup.ps1", "download_flex.ps1", "setup_adobe_flex.ps1",
    "setup_swftools.ps1", "Batch-Decompile.ps1",
}

# Generic Python files (check context)
GENERIC_PYTHON = {
    "__init__.py", "__main__.py", "urls.py", "settings.py", "manage.py",
    "setup.py", "colors.py", "headers.py", "logger.py", "md5.py", "sha.py",
    "sre.py", "referer.py", "select.py", "user.py", "index.py", "_array.py",
    "_collections.py", "_sets.py",
}

# Numbered generic Python
def is_numbered_generic_python(filename):
    patterns = ["__init___", "__main___", "urls_", "index_", "client_"]
    for p in patterns:
        if filename.startswith(p) and filename.endswith(".py"):
            return True
    return False

# Numbered metadata/config JSON
def is_numbered_metadata(filename):
    if filename.startswith("metadata_") and filename.endswith(".json"):
        return True
    if filename.startswith("config.sol_") and filename.endswith(".json"):
        return True  # These might be Evony, but there are 123 of them - keep a sample
    return False

# Numbered patternconstraints
def is_numbered_pattern(filename):
    patterns = ["patternconstraints_", "prepatternconstraints_"]
    for p in patterns:
        if filename.startswith(p) and filename.endswith(".xml"):
            return True
    return False

# Generic docs
GENERIC_DOCS = {
    "ChangeHistory.md", "InstallationGuide.md", "WhatsNew.md", "FAQ.md",
    "contact-us.md", "Grammar.txt", "PatternGrammar.txt", "syntaxes.txt",
    "cuda-config.md", "requirements-cuda.md", "requirements.md",
}

# Other misc junk
MISC_JUNK = {
    ".pre-commit-config.yaml", ".travis.yml", "pytest.ini",
    "gradlew.bat", "make.bat", "app.yaml", "web.xml",
    "clsids.txt", "guids.txt", "entry_points.txt", "top_level.txt",
    "common_symbols_win32.txt", "common_symbols_win64.txt",
    "default.gnu.demangler.replacements.txt", "etk_related_strings.txt",
    "manual_index.txt", "debug.log4j.xml", "schema.xml", "temp.xml",
    "namespace.xml", "downloads.xml", "charset_info.xml",
    "flash-unicode-table.xml", "Languages.xml", "ms_pe_rich_products.xml",
    "UDPExample-app.xml", "com.jpexs.decompiler.flash.metainfo.xml",
    "DOTNET Framework v3.5 Client.FileList.xml", "DOTNET Framework v4.0 Client.FileList.xml",
    "DotNet.ex.xml", "run_suite.bat", "test_validation.bat",
}

# ============================================================================
# EVONY-RELATED KEYWORDS (for filename checking)
# ============================================================================

EVONY_FILENAME_KEYWORDS = {
    "evony", "autoevony", "roboevony", "borg", "commission", "quest",
    "castle", "colony", "troop", "hero", "alliance", "npc", "valley",
    "glitch", "attack", "army", "city", "feeder", "spam", "draft", "scanmap",
    "fastattack", "disarm", "hh_", "legendary", "khan", "exploit", "protocol",
    "bot", "script", "accounts", "userpass", "login", ".sol", "amf",
}

# ============================================================================
# MAIN LOGIC
# ============================================================================

def should_trash(filename: str) -> Tuple[bool, str]:
    """
    Check if a file should be trashed based on its filename only.
    Returns (should_trash, reason)
    """
    name_lower = filename.lower()
    
    # 1. Check exact matches in trash sets
    if filename in VIRUS_GROUP_DOCS:
        return True, "virus_group_doc"
    if filename in LICENSE_EXACT:
        return True, "license_file"
    if filename in GHIDRA_PATTERNS:
        return True, "ghidra_pattern"
    if filename in GHIDRA_DOCS:
        return True, "ghidra_doc"
    if filename in GHIDRA_BATCHES:
        return True, "ghidra_batch"
    if filename in GHIDRA_PYTHON:
        return True, "ghidra_python"
    if filename in GHIDRA_XMLS:
        return True, "ghidra_xml"
    if filename in DECOMPILER_XMLS:
        return True, "decompiler_xml"
    if filename in FLEX_BATCHES:
        return True, "flex_batch"
    if filename in FLEX_XMLS:
        return True, "flex_xml"
    if filename in WEB_JUNK:
        return True, "web_junk"
    if filename in FLEX_STYLE_FILES:
        return True, "flex_style"
    if filename in PS_OTHER_TOOLS:
        return True, "ps_other_tool"
    if filename in GENERIC_DOCS:
        return True, "generic_doc"
    if filename in MISC_JUNK:
        return True, "misc_junk"
    
    # 2. Check patterns
    if is_bundle_or_compile_config(filename):
        return True, "flex_config_numbered"
    if is_dnspy_file(filename):
        return True, "dnspy"
    if is_numbered_pattern(filename):
        return True, "decompiler_pattern_numbered"
    if is_numbered_generic_python(filename):
        # Check if NOT Evony-related first
        if not any(kw in name_lower for kw in EVONY_FILENAME_KEYWORDS):
            return True, "generic_python_numbered"
    if is_numbered_metadata(filename):
        # Keep a few, trash the rest
        if "metadata_" in filename:
            return True, "metadata_numbered"
    
    # 3. Check generic Python (only if no Evony keywords)
    if filename in GENERIC_PYTHON:
        if not any(kw in name_lower for kw in EVONY_FILENAME_KEYWORDS):
            return True, "generic_python"
    
    # 4. Travis/requirements numbered
    if filename.startswith(".travis_") or filename.startswith("requirements_"):
        return True, "config_numbered"
    
    # 5. Schema numbered
    if filename.startswith("schema_") and filename.endswith(".xml"):
        return True, "schema_numbered"
    
    # 6. README duplicates (hashed versions) - but keep the main ones
    if filename.startswith("README_") and len(filename) > 15 and filename.endswith(".md"):
        # Keep if has Evony keywords
        if any(kw in name_lower for kw in EVONY_FILENAME_KEYWORDS):
            return False, "evony_readme"
        # If it's a hash-named one, trash it
        if "_" in filename and filename[7:15].replace("_", "").replace("-", "").isalnum():
            return True, "readme_hash_duplicate"
    
    # 7. Index duplicates
    if filename.startswith("index_") and filename.endswith(".md"):
        if len(filename) > 15:  # index_xxxxxxxx.md format
            return True, "index_hash_duplicate"
    
    # Keep by default
    return False, "keep"


def scan_and_sort():
    """Main sorting function"""
    # Create trash directory
    TRASH_DIR.mkdir(exist_ok=True)
    
    # Track stats
    stats = {
        "kept": [],
        "trashed": [],
        "errors": [],
    }
    
    # Folders to scan
    scan_folders = [
        BASE_DIR / "keys",
        BASE_DIR / "protocols",
    ]
    
    for folder in scan_folders:
        if not folder.exists():
            print(f"Folder not found: {folder}")
            continue
        
        print(f"\n{'='*60}")
        print(f"Scanning: {folder.name}")
        print(f"{'='*60}")
        
        # Create subfolder in trash
        trash_subfolder = TRASH_DIR / folder.name
        trash_subfolder.mkdir(exist_ok=True)
        
        for filepath in folder.iterdir():
            if filepath.is_dir():
                continue
            
            filename = filepath.name
            
            # Check if should trash
            trash_it, reason = should_trash(filename)
            
            if trash_it:
                try:
                    dest = trash_subfolder / filename
                    # Handle duplicates
                    if dest.exists():
                        base, ext = os.path.splitext(filename)
                        i = 1
                        while dest.exists():
                            dest = trash_subfolder / f"{base}_{i}{ext}"
                            i += 1
                    shutil.move(str(filepath), str(dest))
                    stats["trashed"].append((filepath, reason))
                    print(f"  TRASH: {filename} [{reason}]")
                except Exception as e:
                    stats["errors"].append((filepath, str(e)))
                    print(f"  ERROR: {filename} - {e}")
            else:
                stats["kept"].append((filepath, reason))
    
    return stats


def generate_report(stats):
    """Generate a summary report"""
    report = []
    report.append("\n" + "="*60)
    report.append("SORTING REPORT")
    report.append("="*60)
    
    report.append(f"\nKept: {len(stats['kept'])} files")
    report.append(f"Trashed: {len(stats['trashed'])} files")
    report.append(f"Errors: {len(stats['errors'])} files")
    
    # Group trashed by reason
    report.append("\n--- TRASHED FILES BY REASON ---")
    reasons = {}
    for filepath, reason in stats["trashed"]:
        if reason not in reasons:
            reasons[reason] = []
        reasons[reason].append(filepath.name)
    
    for reason_type, files in sorted(reasons.items(), key=lambda x: -len(x[1])):
        report.append(f"\n{reason_type}: {len(files)} files")
        for f in files[:10]:
            report.append(f"  - {f}")
        if len(files) > 10:
            report.append(f"  ... and {len(files)-10} more")
    
    # Group kept by reason  
    report.append("\n--- KEPT FILES (sample) ---")
    kept_count = 0
    for filepath, reason in stats["kept"][:20]:
        report.append(f"  KEEP: {filepath.name}")
        kept_count += 1
    if len(stats["kept"]) > 20:
        report.append(f"  ... and {len(stats['kept'])-20} more kept files")
    
    if stats["errors"]:
        report.append("\n--- ERRORS ---")
        for filepath, error in stats["errors"]:
            report.append(f"  {filepath.name}: {error}")
    
    return "\n".join(report)


if __name__ == "__main__":
    print("Evony Dataset Sorter - Phase 4 (Fixed)")
    print("="*60)
    
    stats = scan_and_sort()
    report = generate_report(stats)
    print(report)
    
    # Save report
    report_path = BASE_DIR / "sorting_report.txt"
    with open(report_path, "w", encoding="utf-8") as f:
        f.write(report)
    print(f"\nReport saved to: {report_path}")
