#!/system/bin/sh

# ==========================================
#  Universal System Optimizer - Magisk Module
#  Author: @saltfor (Telegram)
#  Version: 1.0
# ==========================================

# --- ASCII Art ---
ui_print " "
ui_print "  ██████╗ ██████╗ ███████╗██╗   ██╗"
ui_print " ██╔═══██╗██╔══██╗██╔════╝██║   ██║"
ui_print " ██║   ██║██████╔╝█████╗  ██║   ██║"
ui_print " ██║   ██║██╔═══╝ ██╔══╝  ██║   ██║"
ui_print " ╚██████╔╝██║     ██║     ╚██████╔╝"
ui_print "  ╚═════╝ ╚═╝     ╚═╝      ╚═════╝"
ui_print " "

# --- Initial Setup ---
ui_print "- Initializing..."
sleep 0.5

MODPATH_SYSTEM_PROP="$MODPATH"/system.prop
MOD_PROP_VERSION=$(grep_prop version "$MODPATH"/module.prop)
MOD_PROP_DEVICE=$(getprop ro.product.model)
MOD_PROP_ANDROID=$(getprop ro.build.version.release)

ui_print "  [DEVICE] $MOD_PROP_DEVICE"
ui_print "  [ANDROID] $MOD_PROP_ANDROID"
sleep 0.3

# --- Fancy Progress Animation ---
animate_progress() {
    text="$1"
    ui_print " "
    ui_print ">>> $text <<<"
    
    i=1
    while [ $i -le 5 ]; do
        progress=""
        j=1
        while [ $j -le $i ]; do
            progress="$progress▓"
            j=$((j + 1))
        done
        j=$i
        while [ $j -lt 5 ]; do
            progress="$progress░"
            j=$((j + 1))
        done
        
        ui_print "  [$i/5] $progress"
        sleep 0.2
        i=$((i + 1))
    done
    ui_print "  [✓] Done"
    sleep 0.3
}

# --- Main Optimization Process ---
ui_print " "
ui_print "==== STARTING OPTIMIZATION PROCESS ===="
sleep 1

# 1. System Tweaks
animate_progress "Applying System Tweaks"
setprop persist.sys.force_sw_gles 0
setprop ro.config.hw_quickpoweron true
setprop pm.dexopt.bg-dexopt speed-profile

# 2. Memory Optimization
animate_progress "Optimizing Memory"
setprop ro.config.fha_enable true
sleep 0.1

# 3. Network Boost
animate_progress "Boosting Network"
setprop net.tcp.buffersize.default 4096,87380,256960,4096,16384,256960
setprop net.ipv4.tcp_window_scaling 1
setprop net.ipv4.tcp_moderate_rcvbuf 1

# 5. Battery Optimization
animate_progress "Optimizing Battery"
cmd settings put global adaptive_battery_management_enabled 0
cmd settings put system intelligent_sleep_mode 0
cmd settings put secure adaptive_sleep 0

# --- Universal App Optimizations ---
ui_print " "
ui_print "==== OPTIMIZING SYSTEM APPS ===="
sleep 0.5

# Google Apps
ui_print " "
ui_print "  [DISABLING] Google Services:"
for pkg in \
    com.google.android.tts \
    com.google.android.syncadapters.calendar \
    com.google.android.googlequicksearchbox \
    com.google.android.partnersetup \
    com.google.android.gms.location.history
do
    pm disable-user "$pkg" >/dev/null 2>&1
    ui_print "    - $pkg"
    sleep 0.05
done

# System Apps
ui_print " "
ui_print "  [DISABLING] System Apps:"
for pkg in \
    com.android.egg \
    com.android.providers.calendar \
    com.android.hotwordenrollment.okgoogle \
    com.android.stk \
    com.android.printspooler
do
    pm disable-user "$pkg" >/dev/null 2>&1
    ui_print "    - $pkg"
    sleep 0.05
done

# --- Cleanup ---
animate_progress "Cleaning System Cache"
ui_print "  [CLEARING] Application caches..."
pm trim-caches 99999G
rm -rf /data/data/*/cache/*
rm -rf /sdcard/Android/data/*/cache/
rm -rf /sdcard/Android/obb/*/cache/
find /storage/emulated/0 -type d -empty -delete 2>/dev/null
ui_print "››CLEARING‹‹ /cache/"
rm -rf /cache/*
sleep 0.2
ui_print "››CLEARING‹‹ /tmp/"
rm -rf /tmp/*
sleep 0.2
ui_print "››CLEARING‹‹ /data/local/tmp/"
rm -rf /data/local/tmp/*
sleep 1
# --- Finalization ---
ui_print " "
ui_print "==== FINALIZING INSTALLATION ===="
sleep 0.2
ui_print "-Reset package compile-"
cmd package compile --reset -a
ui_print "Done"
sleep 0.5
ui_print "Apply package compile quicken"

excluded_games="antutu|adventure.rpg.anime.game.vng.ys6|age.of.civilizations2.jakowski.lukasz|air.com.ubisoft.brawl.halla.platform.fighting.action.pvp|brownmonster.app.game.rushrally3|com.AlfaBravo.Combat|com.CarXTech.street|com.ChillyRoom.DungeonShooter|com.EtherGaming.PocketRogues|com.Flanne.MinutesTillDawn.roguelike.shooting.gp|com.FosFenes.Sonolus|com.GameCoaster.ProtectDungeon|com.HoYoverse.Nap|com.HoYoverse.hkrpgoversea|com.LanPiaoPiao.PlantsVsZombiesRH|com.PigeonGames.Phigros|com.ProjectMoon.LimbusCompany|com.Psyonix.RL2D|com.RoamingStar.BlueArchive|com.Shooter.ModernWarship|com.Shooter.ModernWarships|com.Sunborn.SnqxExilium|com.Sunborn.SnqxExilium.Glo|com.TechTreeGames.TheTower|com.Vince.AlamobileFormula|com.WandaSoftware.TruckersofEurope3|com.Wispwood.ArrowQuest|com.YoStarEN.Arknights|com.YoStarEN.HBR|com.YoStarEN.MahjongSoul|com.YoStarJP.MajSoul|com.YoStar.AetherGazer|com.YostarJP.BlueArchive|com.ZeroCastleGameStudioINTL.StrikeBusterPrototype|com.ZeroCastleGameStudio.StrikeBusterPrototype|com.activision.callofduty.shooter|com.activision.callofduty.warzone|com.albiononline|com.aligames.kuang.kybc|com.aligames.kuang.kybc.huawei|com.alightcreative.motion|com.asobimo.toramonline|com.android.test.uibench|com.andromeda.androbench2|com.and.games505.Terraria|com.archosaur.sea.dr.gp|com.autumn.skullgirls|com.axlebolt.standoff2|com.bandainamcoent.idolmaster_gakuen|com.bandainamcoent.imas_millionlive_theaterdays|com.bandainamcoent.opbrww|com.bandainamcoent.sao|com.bandainamcoent.shinycolorsprism|com.bandainamcoent.tensuramrkww|com.bandainamcoent.ultimateninjastorm|com.bandainamcogames.dbzdokkanww|com.bhvr.deadbydaylight|com.bilibiligame.heglgp|com.bilibili.azurlane|com.bilibili.deadcells.mobile|com.bilibili.fatego|com.bilibili.priconne|com.bilibili.star.bili|com.bilibili.warmsnow|com.bingkolo.kleins.cn|com.blizzard.diablo.immortal|com.bluepoch.m.en.reverse1999|com.bushiroad.d4dj|com.bushiroad.en.bangdreamgbp|com.bushiroad.lovelive.schoolidolfestival2|com.carxtech.sr|com.chillyroom.soulknightprequel|com.citra.emu|com.cnvcs.xiangqi|com.com2us.starseedgl.android.google.global.normal|com.criticalforceentertainment.criticalops|com.crunchyroll.princessconnectredive|com.denachina.g13002010|com.dena.a12026801|com.denchi.vtubestudio|com.devsisters.ck|com.dfjz.moba|com.dgames.g15002002|com.dois.greedgame|com.dolphinemu.dolphinemu|com.dragonli.projectsnow.lhm|com.drivezone.car.race.game|com.dts.freefireadv|com.dts.freefiremax|com.dts.freefireth|com.dts.freefireth.huawei|com.dxx.firenow|com.ea.games.r3_row|com.ea.game.pvz2_rfl|com.ea.game.pvz2_row|com.ea.game.pvzfree_row|com.ea.gp.apexlegendsmobilefps|com.ea.gp.fifamobile|com.ea.gp.nfsm|com.emulator.fpse64|com.eyougame.msen|com.epicgames.fortnite|com.epicgames.portal|com.epsxe.ePSXe|com.fantablade.icey|com.farlightgames.igame.gp|com.feralinteractive.gridas|com.feralinteractive.gridautosport_edition_android|com.firewick.p42.bilibili|com.firsttouchgames.dls7|com.fizzd.connectedworlds|com.futuremark.dmandroid.application|com.gabama.monopostolite|com.gaijingames.wtm|com.gakpopuler.gamekecil|com.gameark.ggplay.lonsea|com.gamedevltd.wwh|com.gameloft.android.ANMP.GloftA9HM|com.gameloft.android.ANMP.GloftMVHM|com.gameloft.android.SAMS.GloftA9SS|com.garena.game.codm|com.garena.game.kgid|com.garena.game.kgtw|com.garena.game.kgvn|com.garena.game.lmjx|com.garena.game.nfsm|com.gravity.romg|com.gravity.roo.sea|com.gryphline.exastris.gp|com.guyou.deadstrike|com.halo.windf.hero|com.heavenburnsred|com.hermes.j1game|com.herogame.gplay.magicminecraft.mmorpg|com.hg.cosmicshake|com.hottapkgs.hotta|com.hypergryph.arknights|com.hypergryph.exastris|com.igg.android.doomsdaylastsurvivors|com.ignm.raspberrymash.jp|com.ilongyuan.implosion|com.infoldgames.infinitynikkien|com.jacksparrow.jpmajiang|com.japan.datealive.gp|com.je.supersus|com.kakaogames.eversoul|com.kakaogames.gdts|com.kakaogames.wdfp|com.kiloo.subwaysurf|com.kog.grandchaseglobal|com.komoe.kmumamusumegp|com.kurogame.aki|com.kurogame.gplay.punishing.grayraven.en|com.kurogame.haru|com.kurogame.haru.bilibili|com.kurogame.haru.hero|com.kurogame.mingchao|com.kurogame.wutheringwaves.global|com.leiting.wf|com.lemcnsun.soultide.android|com.levelinfinite.hotta.gp|com.levelinfinite.sgameGlobal|com.levelinfinite.sgameGlobal.midaspay|com.lilithgames.hgame.cn|com.lilithgame.hgame.gp|com.lilithgame.roc.gp|com.linecorp.LGGRTHN|com.linegames.sl|com.lrgame.dldl.sea|com.madfingergames.legends|com.maleo.bussimulatorid|com.miHoYo.GI.samsung|com.miHoYo.GenshinImpact|com.miHoYo.HSoDv2JPOriginalEx|com.miHoYo.Nap|com.miHoYo.Yuanshen|com.miHoYo.bh3|com.miHoYo.bh3oversea_vn|com.miHoYo.bh3rdJP|com.miHoYo.bh3global|com.miHoYo.bh3oversea|com.miHoYo.bh3.bilibili|com.miHoYo.bh3.mi|com.miHoYo.bh3.uc|com.miHoYo.enterprise.NGHSoD|com.miHoYo.hkrpg|com.miHoYo.ys|com.miHoYo.zenless|com.minidragon.idlefantasy|com.miraclegames.farlight84|com.mobilelegends.hwag|com.mobilelegends.mi|com.mobilelegends.taptest|com.mobile.legends|com.mobilechess.gp|com.mojang.hostilegg|com.mojang.minecraftpe|com.mojang.minecraftpe.patch|com.nanostudios.games.twenty.minutes|com.ncsoft.lineagen|com.npixel.GranSagaGB|com.nebulajoy.act.dmcpoc.asia|com.nekki.shadowfight|com.nekki.shadowfight3|com.neowizgames.game.browndust2|com.netease.AVALON|com.netease.EVE|com.netease.aceracer|com.netease.dfjs|com.netease.dwrg|com.netease.eve.en|com.netease.frxyna|com.netease.g78na.gb|com.netease.g93na|com.netease.h75na|com.netease.hyxd|com.netease.idv|com.netease.jddsaef|com.netease.ko|com.netease.lagrange|com.netease.lglr|com.netease.lztgglobal|com.netease.ma84|com.netease.ma100asia|com.netease.moba|com.netease.mrzh|com.netease.newspike|com.netease.nshm|com.netease.onmyoji|com.netease.party|com.netease.partyglobal|com.netease.race|com.netease.racerna|com.netease.sky|com.netease.soulofhunter|com.netease.tj|com.netease.tom|com.netease.wotb|com.netease.x19|com.netease.yhtj|com.netflix.NGP.GTAIIIDefinitiveEdition|com.netflix.NGP.GTASanAndreasDefinitiveEdition|com.netflix.NGP.GTAViceCityDefinitiveEdition|com.netmarble.skiagb|com.netmarble.sololv|com.netmarble.tog|com.nexon.bluearchive|com.nexon.konosuba|com.neowiz.game.idolypride.en|com.nexon.kartdrift|com.noctua.android.crazyones|com.noctuagames.android.ashechoes|com.ngame.allstar.eu|com.nianticlabs.monsterhunter|com.olzhass.carparking.multyplayer|com.papegames.nn4.en|com.pearlabyss.blackdesertm.gl|com.pearlabyss.blackdesertm|com.pinkcore.tkfm|com.plarium.raidlegends|com.playdigious.deadcells.mobile|com.playmini.miniworld|com.play.rosea|com.popcap.pvz|com.primatelabs.geekbench6|com.proximabeta.dn2.global|com.proximabeta.mf.aceforce2|com.proximabeta.mf.liteuamo|com.proximabeta.mf.uamo|com.proximabeta.nikke|com.prpr.musedash|com.pubg.imobile|com.pubg.krmobile|com.pubg.newstate|com.pwrd.hotta.laohu|com.pwrd.huanta|com.pwrd.opmwsea|com.pwrd.p5x|com.pwrd.persona5x.laohu|com.r2games.myhero.bilibili|com.rayark.deemo2|com.rayark.deemoreborn|com.rayark.cytus2|com.rayark.implosion|com.rayark.sdorica|com.rekoo.pubgm|com.rinzz.projectmuse|com.riotgames.league.teamfighttactics|com.riotgames.league.teamfighttacticstw|com.riotgames.league.teamfighttacticsvn|com.riotgames.league.wildrift|com.roblox.client|com.robtopx.geometryjump|com.rockstargames.gta3|com.rockstargames.gta3.de|com.rockstargames.gtasa|com.rockstargames.gtasa.de|com.rockstargames.gtavc|com.rockstargames.gtavc.de|com.rsg.myheroesen|com.sandboxinteractive.albiononline|com.sandboxol.blockymods|com.seasun.jx3|com.seasun.snowbreak.google|com.sega.ColorfulStage.en|com.sega.pjsekai|com.sgra.dragon|com.shangyoo.neon|com.shatteredpixel.shatteredpixeldungeon|com.shenlan.m.reverse1999|com.silverstarstudio.angellegion|com.smokoko.race|com.sofunny.Sausage|com.soulgamechst.majsoul|com.spaceapegames.beatstar|com.sprduck.garena.vn|com.squareenix.lis|com.stove.epic7.google|com.sugarfun.gp.sea.lzgwy|com.sunborn.girlsfrontline.en|com.sunborn.neuralcloud|com.sunborn.neuralcloud.en|com.superb.rhv|com.supercell.brawlstars|com.supercell.clashofclans|com.supercell.clashroyale|com.supercell.hayday|com.supercell.squad|com.studiobside.CounterSide|com.studiowildcard.wardrumstudios.ark|com.studiowildcard.wardrumstudios.ark.ncr|com.sy.dldlhsdj|com.sybogames.subway.surfers.game|com.t2ksports.nba2k20and|com.tencent.KiHan|com.tencent.af|com.tencent.baiyeint|com.tencent.ig|com.tencent.iglite|com.tencent.jkchess|com.tencent.lolm|com.tencent.mf.uam|com.tencent.msgame|com.tencent.nfsonline|com.tencent.tmgp.WePop|com.tencent.tmgp.bh3|com.tencent.tmgp.cf|com.tencent.tmgp.cod|com.tencent.tmgp.dfjs|com.tencent.tmgp.dfm|com.tencent.tmgp.dwrg|com.tencent.tmgp.ffom|com.tencent.tmgp.gnyx|com.tencent.tmgp.kr.codm|com.tencent.tmgp.pubgmhd|com.tencent.tmgp.sgame|com.tencent.tmgp.sgamece|com.tencent.tmgp.sskeus|com.tencent.tmgp.speedmobile|com.tencent.tmgp.wuxia|com.tencent.tmgp.yys.zqb|com.tencent.toaa|com.tgc.sky.android|com.the10tons.dysmantle|com.tinybuildgames.helloneighbor|com.tipsworks.android.pascalswager|com.tipsworks.pascalswager|com.tumuyan.ncnn.realsr|com.tungsten.fcl|com.ubisoft.rainbowsixmobile.r6.fps.pvp.shooter|com.unity.mmd|com.valvesoftware.cswgsm|com.valvesoftware.source|com.vng.mlbbvn|com.vng.pubgmobile|com.vng.speedvn|com.winlator|com.wondergames.warpath.gp|com.xd.TLglobal|com.xd.muffin.gp.global|com.xd.rotaeno.googleplay|com.xd.rotaeno.tapcn|com.xd.ssrpgen|com.xd.terraria|com.xindong.torchlight|com.yongshi.tenojo|com.yoozoo.jgame.global|com.yoozoo.jgame.us|com.zlongame.mhmnz|com.ztgame.bob|com.ztgame.yyzy|com.zy.wqmt.cn|cyou.joiplay.joiplay|game.qualiarts.idolypride|id.rj01117883.liomeko|jp.co.bandainamcoent.BNEI0242|jp.co.craftegg.band|jp.co.cygames.princessconnectredive|jp.co.cygames.umamusume|jp.co.koeitecmo.ReslerianaGL|jp.garud.ssimulator|jp.goodsmile.touhoulostwordglobal_android|jp.konami.duellinks|jp.konami.masterduel|jp.konami.pesam|jp.pokemon.pokemonunite|lega.feisl.hhera|me.mugzone.emiria|me.pou.app|me.tigerhix.cytoid|moe.low.arc|net.kdt.pojavlaunch|net.wargaming.wot.blitz|org.dolphinemu.dolphinemu|org.godotengine.godot4|org.mm.jr|org.ppsspp.ppsspp|org.ppsspp.ppssppgold|org.vita3k.emulator|org.openttd.sdl|org.sudachi.sudachi_emu.ea|org.yuzu.yuzu_emu|pro.archiemeng.waifu2x|ro.alyn_sampmobile.game|ru.nsu.ccfit.zuev.osuplus|ru.unisamp_mobile.game|sh.ppy.osulazer|skyline.emu|skyline.purple|skynet.cputhrottlingtest|tw.sonet.allbw|uk.co.powdertoy.tpt|vng.games.revelation.mobile|xd.sce.promotion|xyz.aethersx2.android"

pm list packages | grep -Ev "$excluded_games" | cut -d':' -f2 | while read pkg; do
    cmd package compile -f -m quicken "$pkg"
done

ui_print "Done"
sleep 1
ui_print "Apply package compile speed"

echo "$excluded_games" | tr '|' '\n' | while read game; do
    cmd package compile -f -m speed "$game"
done

sleep 0.5
ui_print "Running final optimizations..."
cmd package bg-dexopt-job
ui_print "Done"

# --- Final ASCII Art ---
ui_print " "
ui_print "========================================"
ui_print "|                                      |"
ui_print "|        OPTIMIZATION COMPLETE!        |"
ui_print "|                                      |"
ui_print "========================================"
ui_print " "
ui_print "  [NOTE] Reboot system" 
ui_print "         To apply all modifications "
ui_print " "
ui_print "----------------------------------------"
ui_print "  Telegram: @saltfor"
ui_print "  Thanks for using our module!"
ui_print "----------------------------------------"
ui_print " "

sleep 2