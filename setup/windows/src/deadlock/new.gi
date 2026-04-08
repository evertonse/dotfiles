"GameInfo"
{
    game        "citadel"
    title       "Citadel"
    type        multiplayer_only
    nomodels 1
    nohimodel 1
    nocrosshair 0
    hidden_maps
    {
        "test_speakers"         1
        "test_hardware"         1
    }
    nodegraph 0
    perfwizard 0
    tonemapping 0 
    GameData    "citadel.fgd"
    
    Localize
    {
        DuplicateTokensAssert   1
        DisallowTokenContexts   1
    }

    SupportedLanguages
    {
        "brazilian" "3"
        "czech" "3"
        "english" "3"
        "french" "3"
        "german" "3"
        "italian" "3"
        "indonesian" "3"
        "japanese" "3"
        "koreana" "3"
        "latam" "3"
        "polish" "3"
        "russian" "3"
        "schinese" "3"
        "spanish" "3"
        "thai" "3"
        "turkish" "3"
        "ukrainian" "3"
    }
    
    FileSystem
    {   
        //
        // The code that loads this file automatically does a few things here:
        //
        // 1. For each "Game" search path, it adds a "GameBin" path, in <dir>\bin
        // 2. For each "Game" search path, it adds another "Game" path in front of it with _<language> at the end.
        //    For example: c:\hl2\cstrike on a french machine would get a c:\hl2\cstrike_french path added to it.
        // 3. If no "Mod" key, for the first "Game" search path, it adds a search path called "MOD".
        // 4. If no "Write" key, for the first "Game" search path, it adds a search path called "DEFAULT_WRITE_PATH".
        //

        //
        // Search paths are relative to the exe directory\..\
        //
    
// Deadlock Mod Manager - Start

        SearchPaths
        {  
            Game_Language       citadel_*LANGUAGE*
            Game                citadel/addons
            Mod                 citadel
            Write               citadel          
            Game                citadel
            Mod                 core
            Write               core
            Game                core        
        }
// Deadlock Mod Manager - End
    }
    
    MaterialSystem2
    {
        RenderModes
        {
            game Default
            game Forward
            game Deferred
            game Outline
            game Depth
            game FrontDepth

            dev ToolsVis // Visualization modes for all shaders (lighting only, normal maps only, etc.)
            dev ToolsWireframe // This should use the ToolsVis mode above instead of being its own mode\

            tools ToolsUtil // Meant to be used to render tools sceneobjects that are mod-independent, like the origin grid
        }
    }

    MaterialEditor
    {
        "DefaultShader" "environment_texture_set"
    }

    NetworkSystem
    {
        BetaUniverse
        {
            FakeLag         40
            FakeLoss        .1
            //FakeReorderPct 0.05
            //FakeReorderDelay 10
            //FakeJitter "low"
            // Turning off fake jitter for now while I work on making the CQ totally solid
            FakeReorderPct 0
            FakeReorderDelay 0
            FakeJitter "off"
        }

        "SkipRedundantChangeCallbacks"  "1"
    }

    RenderSystem
    {
		IndexBufferPoolSizeMB 32
		UseReverseDepth 1
		Use32BitDepthBuffer 0
		Use32BitDepthBufferWithoutStencil 0
		SwapChainSampleableDepth 1
		VulkanMutableSwapchain 1
		"LowLatency"								"1"
		"VulkanOnly_Linux"							"1"
		"VulkanRequireSubgroupWaveOpSupport"		"1"
		"VulkanRequireDescriptorIndexing"			"1"
		"VulkanSteamShaderCache" "1"
		"VulkanSteamAppShaderCache" "1"
		"VulkanSteamDownloadedShaderCache" "1"
		"VulkanAdditionalShaderCache" "vulkan_shader_cache.foz"
		"VulkanStagingPMBSizeLimitMB" "384"
		"GraphicsPipelineLibrary"	"1"
		"VulkanOnlyTestProbability" "0"
		"VulkanDefrag"				"1"
		"MinStreamingPoolSizeMB"	"1024"
		"MinStreamingPoolSizeMBTools" "2048"
    }

    NVNGX
    {
        AppID 103371621
        SupportsDLSS 1
    }

    Engine2
    {
        HasModAppSystems 1
        Capable64Bit 1
        URLName citadel
        RenderingPipeline
        {
            SupportsMSAA 0
            DistanceField 1
        }
        PauseSinglePlayerOnGameOverlay 1
        DefensiveConCommands 1
        DisableLoadingPlaque 1
    }

    ContentBuilder
    {
        ResourceCompilerDirectXUsesWARP "0"
    }

    SoundSystem
    {
        SteamAudioEnabled            "1"
        WaveDataCacheSizeMB          "256"
        "UsePlatTime"            "1"
    }
    Sounds
    {
        HierarchicalEncodingFiles    "1"
    }

    ToolsEnvironment
    {
        "Engine"    "Source 2"
        "ToolsDir"  "../sdktools"   // NOTE: Default Tools path. This is relative to the mod path.
    }
    
    pulse
    {
        "pulse_enabled"                 "1"
    }

    Hammer
    {
        "fgd"                   "citadel.fgd"   // NOTE: This is relative to the 'game' path.
        "GameFeatureSet"        "Citadel"
        "DefaultSolidEntity"    "trigger_multiple"
        "DefaultPointEntity"    "info_player_start"
        "NavMarkupEntity"       "func_nav_markup"
        "OverlayBoxSize"            "8"
        "TileMeshesEnabled"         "1"
        "RenderMode"                "ToolsVis"
        "CreateRenderClusters"      "1"
        "DefaultMinDrawVolumeSize"  "2048"
        "DefaultMinTrianglesPerCluster" "16384"
        "TileGridSupportsBlendHeight"   "1"
        "TileGridBlendDefaultColor" "0 255 0"
        "LoadScriptEntities" "0"
        "UsesBakedLighting" "1"
        "UseAnalyticGrid" "0"
        "SupportsDisplacementMapping" "0"
        "SteamAudioEnabled"             "1"
        "LatticeDeformerEnabled"        "1"
        "ShadowAtlasWidth" "16384"
        "ShadowAtlasHeight" "16384"
        "TimeSlicedShadowMapRendering" "1"
    }

    SoundTool
    {
        "DefaultSoundEventType" "src1_3d"

        SoundEventBaseOptions
        {
            "Base.Announcer.VO.2d" ""
            "Base.World.VO.Emitter.3d" ""
            "Base.Hero.VO.Ping.2d" ""
            "Base.Hero.VO.2d" ""
            "Base.Hero.VO.3d" ""
            "Base.Hero.VO.Ability.3d" ""
            "Base.Hero.VO.Ultimate.3d" ""
            "Base.Hero.VO.Dash.3d" ""
            "Base.Hero.VO.Effort.3d" ""
            "Base.Hero.VO.Pain.3d" ""
            "Base.Hero.VO.Melee.3d" ""
            "Base.Hero.VO.Death.3d" ""
        }
    }

    RenderPipelineAliases
    {
    }

    ResourceCompiler
    {
        // Overrides of the default builders as specified in code, this controls which map builder steps
        // will be run when resource compiler is run for a map without specifiying any specific map builder
        // steps. Additionally this controls which builders are displayed in the hammer build dialog.
        DefaultMapBuilders
        {
            "bakedlighting" "1" // Enable lightmapping during compile time      
            "envmap"    "0" // turned off since it currently causes an assert and doesn't work due to some build issue
            "nav"       "1" // Generate nav mesh data
        }

        MeshCompiler
        {
            OptimizeForMeshlets 1
            TrianglesPerMeshlet 64  // Maximum valid value currently is 126
            UseMikkTSpace 1
            EncodeVertexBuffer 1
            EncodeVertexBufferVersion 1
            EncodeVertexBufferLevel 3
            EncodeIndexBuffer 1
            SplitDepthStream 1
        }

        WorldRendererBuilder
        {
            VisibilityGuidedMeshClustering      "1"
            MinimumTrianglesPerClusteredMesh    "8192"
            MinimumVerticesPerClusteredMesh     "8192"
            MinimumVolumePerClusteredMesh       "8192"       // ~20x20x20 cube
            MaxPrecomputedVisClusterMembership  "96"
            MaxCullingBoundsGroups              "128"
            UseAggregateInstances               "1"
            AggregateInstancingMeshlets         "1"
            BakePropsWithExtraVertexStreams     "1"
        }

        BakedLighting
        {
            Version 4
            ImportanceVolumeTransitionRegion 512            // distance we transition from high to low resolution charts 
            LightmapChannels
            {
                direct_light_shadows 1
                debug_chart_color 1
                directional_irradiance_sh2_dc 1
                
                directional_irradiance_sh2_r
                {
                    CompressedFormat DXT1
                }
                
                directional_irradiance_sh2_g
                {
                    CompressedFormat DXT1
                }
                
                directional_irradiance_sh2_b
                {
                    CompressedFormat DXT1
                }
            }
            LightmapGutterSize 2 // For bicubic filtering
            UseStaticLightProbes 0
            LPVAtlas 1
            BC6HHueShiftFixup 0 // Causes more artifacts than it solves atm
            Repack2 1
        }

        SteamAudio
        {
            ReverbDefaults
            {
                GridSpacing         "3.0"
                HeightAboveFloor    "1.5"
                RebakeOption        "0"                     // 0: cleanup, 1: manual, 2: auto
                NumRays             "32768"
                NumBounces          "64"
                IRDuration          "1.0"
                AmbisonicsOrder     "1"
            }
            PathingDefaults
            {
                GridSpacing         "3.0"
                HeightAboveFloor    "1.5"
                RebakeOption        "0"                     // 0: cleanup, 1: manual, 2: auto
                NumVisSamples       "1"
                ProbeVisRadius      "0"
                ProbeVisThreshold   "0.1"
                ProbeVisPathRange   "1000.0"
            }
        }
        SoundStackScripts
        {
            CompileStacksStrict "1"
        }
        VisBuilder
        {
            MaxVisClusters "4096"
            PreMergeOpenSpaceDistanceThreshold "128.0"
            PreMergeOpenSpaceMaxDimension "2048.0"
            PreMergeOpenSpaceMaxRatio "8.0"
            PreMergeSmallRegionsSizeThreshold "20.0"
        }

        VDataLocalization
        {
            GameOutputPath  "resource/localization/citadel_vdata"
            TokenPrefix     "Citadel_VData_"
        }
        
        TextureCompiler
        {
            //Compressor              "lz4"
            //CompressMipsOnDisk      "1"
            //CompressMinRatio        "95"
            AllowNP2Textures        "1"
            AllowPanoramaMipGeneration  "1"
            //PublicToolsDefaultMaxRes "2048"
        }
    }

    Source1Import
    {
        // this is just copied from the left4dead3 gameinfo.gi
        "forcevtxfileupconvert" 1
    }

    WorldRenderer
    {
        EnvironmentMaps                 1
        EnvironmentMapFaceSize          256
        EnvironmentMapRenderSize        1024
        EnvironmentMapFormat            BC6H
        EnvironmentMapPreviewFormat         BC6H
        EnvironmentMapColorSpace        linear
        EnvironmentMapMipProcessor      GGXCubeMapBlur
        // Build cubemaps into a cube array instead of individual cubemaps.
        "EnvironmentMapUseCubeArray"    1
        "EnvironmentMapCacheSizeTools"  300
        BindlessSceneObjectDesc         CitadelBindlessDesc
        GrassCastsShadows               1
    }

    SceneSystem
    {

        GpuLightBinner 1
        FogCachedShadowAtlasWidth 0
        FogCachedShadowAtlasHeight 0
        FogCachedShadowTileSize 0
        GpuLightBinnerSunLightFastPath 1
        CSMCascadeResolution 0
        SunLightManagerCount 0
        SunLightManagerCountTools 0
        DefaultShadowTextureWidth 0
        DefaultShadowTextureHeight 0
        DynamicShadowResolution 0

        TransformTextureRowCount    1024
        TransformTextureRowCountToolsMode 6144
        SunLightMaxCascadeSize        4
        SunLightShadowRenderMode    Depth
        LayerBatchThresholdFullsort 20
        NonTexturedGradientFog        0
        // Temp till I can add support in citadel shaders
        DisableLateAllocatedTransformBuffer 1
        MinimumLateAllocatedVertexCacheBufferSizeMB 64
        CubemapFog 0
        VolumetricFog 0
        FrameBufferCopyFormat R11G11B10F
        Tonemapping 0
        WellKnownLightCookies
        {
            "blank" "materials/effects/lightcookies/blank.vtex"
            "flashlight" "materials/effects/lightcookies/flashlight.vtex"
        }

        ComputeShaderSkinning 1
    }

    NavSystem
    {
        "NavTileSize" "128.0"
        "NavCellSize" "1.5"
        "NavCellHeight" "2.0"

        // Hull definitions live in scripts/nav_hulls.vdata
        // Preset definitions live in scripts/nav_hulls_presets.vdata
        "NavHullsPreset" "default"

        "NavRegionMinSize" "8"
        "NavRegionMergeSize" "20"
        "NavEdgeMaxLen" "1200"
        "NavEdgeMaxError" "51.0"
        "NavVertsPerPoly" "4"
        "NavDetailSampleDistance" "120.0"
        "NavDetailSampleMaxError" "2.0"
        "NavSmallAreaOnEdgeRemovalSize" "81.0"
    }

    AnimationSystem
    {
        "DisableServerInterpCompensation"   "1"
        "DisableAnimationScript"    "1"
        "ServerPoseRecipeHistorySize"   "60"
        "ClientPoseRecipeHistorySize"   "60"

    }

    ModelDoc
    {
        "models_gamedata"           "models_gamedata.fgd"
        "features"                  "animgraph;modelconfig;gamepreview;wireframe_backfaces;distancefield"
    }

    Particles
    {
        "EnableParticleShaderFeatureBranching"  "1"
        "Float16HDRBackBuffer" "1"
        "PET_SupportFadingOpaqueModels" "1"
        "Features" "non_homogenous_forward_layer_only"
    }

    ConVars
    {    

// === ANIMATION === //

anim_3wayblend 0
anim_decode_forcewritealltransforms 0
anim_disable 1
animgraph_draw_traces 0
animgraph_enable 1
animgraph_enable_dirty_netvar_optimization 1
animgraph_enable_parallel_op_evaluation 1
animgraph_enable_parallel_preupdate 1
animgraph_enable_parallel_update 1
animgraph_footlock_auto_ledge_detection 0
animgraph_footlock_auto_stair_detection 0
animgraph_footlock_calculate_tilt 0
animgraph_footlock_enabled 0
animgraph_footlock_ik_enable 0
animgraph_record_all 0
animgraph_slowdownonslopes_enabled 0
citadel_npc_force_animate_every_tick 0
citadel_player_anim_debug 0
citadel_player_debug_animgraph_movement 0
cl_SetupAllBones 0
cl_bone_cache_optimization 1
cl_jiggle_bone_framerate_cutoff 0
cl_threaded_bone_setup 0
enable_boneflex 0
ik_fabrik_align_chain 0
ik_final_fixup_enable 0
mod_load_anims_async 0
panorama_disable_animations 1
r_enable_rigid_animation 0

// === LOD === //

ai_lod_auto_enabled 1
ai_think_interval_lod_low 1
ai_think_interval_lod_med 0.4
lb_shadow_map_cull_empty_mixed 1
lb_sun_csm_size_cull_threshold_texels 30
lod_TransitionDist -200
net_culloptimization 1
r_aoproxy_cull_dist 0.01
r_citadel_gpu_culling_shadows 1
r_citadel_gpu_culling_two_pass 0
r_cull_duplicate_shadows 1
r_cull_shadowcasters_using_bounds 1
r_cullforperformance 1
r_entity_cull_distance_multiplier 1.5
r_fallback_texture_lod_scale 4
r_frustumcullworld 1
r_gpu_cull 1
r_gpu_cull_models 1
r_gpu_cull_models_range 4600
r_haircull_percent 100
r_lod 0
r_occlusion_culling 1
r_rootlod 2
r_shadowlod 0
r_size_cull_threshold 1.4
r_size_cull_threshold_shadow 200
r_texture_lod_scale 4
sc_allow_dithered_lod 0
sc_dithered_lod_transition_amt 0
sc_instanced_mesh_lod_bias 15
sc_instanced_mesh_lod_bias_shadow 10
sc_instanced_mesh_size_cull_bias 10
sc_instanced_mesh_size_cull_bias_shadow 10
sc_screen_size_lod_scale_override 0.001
skeleton_instance_lod_optimization 0
snd_cull_duplicates 0

// === NETWORK === //

// cl_async_usercmd_send 1
cl_async_usercmd_send_async 1
cl_async_usercmd_send_disabled_recvmargin_min 0.5
cl_clock_buffer_ticks 1
cl_poll_network_early 1
cl_updaterate 64
cl_cmdrate 64
cl_usesocketsforloopback 1

// === NO PREFIX === //

closecaption 0
phonemesnap 0
shaderquality 0

// === PARTICLES === //

cl_aggregate_particles 1
cl_max_particle_pvs_aabb_edge_length 100
cl_particle_batch_mode 1
cl_particle_budget 0
cl_particle_fallback_base 10
cl_particle_fallback_multiplier 20
cl_particle_max_count 0
cl_particle_retire_cost 0.225
cl_particle_sim_fallback_base_multiplier 40
cl_particle_sim_fallback_threshold_ms 0.001
cl_particle_simulate_parallel 1
mat_reduceparticles 1
particle_cluster_nodraw 1
particle_cluster_use_collision_hulls 0
particle_sim_alt_cores 2
r_RainParticleDensity 0
r_citadel_screenspace_particles_full_res 0
r_draw_particle_children_with_parents 1
r_drawparticles 1
r_late_particle_job_sync 1
r_limit_particle_job_duration 1
r_particle_allowprerender 1
r_particle_batch_collections 1
r_particle_cables_cast_shadows 0
r_particle_cables_culling 1
r_particle_cables_render 0
r_particle_cables_render_meshlets 0
r_particle_debug_filter 0
r_particle_depth_feathering 0
r_particle_gpu_implicit 1
r_particle_gpu_implicit_lds_cache 1
r_particle_lighting_enable 0
r_particle_low_res_render 1
r_particle_max_detail_level 0
r_particle_max_draw_distance 32000
r_particle_max_size_cull 1600
r_particle_max_texture_layers 4
r_particle_min_timestep 0.007
r_particle_mixed_resolution_viewstart 800
r_particle_model_new8 0
r_particle_model_per_thread_count 64
r_particle_radius_cull 1
r_particle_shadows 0
r_particle_shadows_compute 0
r_particle_sim_spike_threshold_ms 10
r_particle_skip_postsim 1
r_particle_skip_update 1
r_particle_timescale 1.1
r_particle_update_rate 2
r_threaded_particles 1

// === PHYSICS === //

cl_phys_assume_fixed_tick_interval 0
cl_phys_enabled 1 // @change
cl_phys_maxticks 3
cl_phys_networked_start_sleep 1
cl_phys_props_enable 0
cl_phys_props_max 0
cl_phys_sleep_enable 0
cl_phys_timescale 1
cl_physics_highlight_active 0
parallel_perform_invalidate_physics 1
phys_cull_internal_mesh_contacts 1
phys_dynamic_scaling 1 // @change
phys_expensive_shape_threshold 100
phys_highlight_expensive_objects_strength 0
phys_log_updaters 0
phys_multithreading_enabled 1
phys_powered_ragdoll_debug 0
phys_show_stats 0
phys_step_threaded 0
phys_threaded_cloth_bone_update 1
phys_threaded_kinematic_bone_update 1
phys_threaded_transform_update 1
phys_visualize_traces 0
r_PhysPropStaticLighting 0
r_physics_particle_op_spawn_scale 0

// === PREDICTION === //

cl_pred_optimize 2
cl_pred_parallel_postnetwork 1
cl_predict_after_every_createmove 1
cl_prediction_savedata_postentitypacketreceived 1
cl_predictioncopy_runs 1
cl_predictphysics 0
perf_fire_bullet_firstpredictedonly 1
pred_cloth_pos_max 0
pred_cloth_pos_multiplier 0
pred_cloth_pos_strength 0
pred_cloth_rot_high 0
pred_cloth_rot_low 0
pred_cloth_rot_multiplier 0

// === AI === //

ai_async_queue_max_jobs 8
ai_disabled 1
ai_expression_frametime 0
ai_expression_optimization 1
ai_foot_sweep_enable 0
ai_frametime_limit 0.0052
ai_gather_conditions_async 1
ai_strong_optimizations_no_checkstand 1
ai_think_interval 0.3
ai_use_async_ragdoll_fixup 1

// === AUDIO === //

audio_enable_vmix_mastering 0
audio_relevance_debug_enabled 0

// === BATTERY === //

battery_saver 0

// === BLINK === //

blink_duration 0

// === CITADEL === //

citadel_boss_glow_disabled 1
citadel_breakable_prop_break_airtime 0
citadel_breakable_prop_breakable_enabled 1
citadel_bullet_log_entities_hit 0
citadel_bullet_tracer_recycling_enabled 1
citadel_camera_hero_fov 90
citadel_camera_soft_collision 2 // @change
citadel_camera_soft_collision_angle 360
citadel_camera_wobble_disable 1
citadel_cinematic_intro_duration_npc 0.01
citadel_cinematic_intro_duration_player 0.01
citadel_cinematic_intro_enabled -1
citadel_commend_toast_enemy_seconds 0
citadel_commend_toast_seconds 0
citadel_crosshair_hit_marker_duration 0.25
citadel_damage_indicator 0
citadel_damage_offscreen_indicator_disabled 1
citadel_damage_overlay 0
citadel_damage_report_enable 1
citadel_damage_screen_effects 1
citadel_damage_text_batching_window_ability 1000
citadel_damage_text_lifetime 0.5
citadel_damage_text_show_effectiveness 0
citadel_enable_vdata_sound_preload 1
citadel_enemy_glow_enabled 0
citadel_hideout_ball_show_juggle_count 1
citadel_hideout_ball_show_juggle_fx 1
citadel_hideout_enable_testing_tools 1
citadel_hud_objective_health_enabled 2
citadel_hud_objective_health_idle_timeout 4
citadel_in_world_item_panel_dpi 0.25
citadel_mantle_cancelling_allowed 1
citadel_mantle_horizontal_movement_distance 64
citadel_match_details_lane_stats_time 360
citadel_minimap_draw_fow 0
citadel_minimap_show_hitboxes 0
citadel_minimap_use_canvas_for_neutrals 0
citadel_minimap_use_canvas_for_shop 0
citadel_minimap_use_effects 0
citadel_movement_debugdraw 0
citadel_npc_disable_cockroaches 1
citadel_npc_disable_floor_point_caching 0
citadel_per_weapon_per_surface_impact_effects 0
citadel_player_glow_disabled 0
citadel_player_outline_enemies 0
citadel_portrait_world_renderer_off 1
citadel_post_damage_vignette 0
citadel_show_new_damage_feedback_numbers 0
citadel_trooper_friendly_glow_disabled 1
citadel_trooper_glow_disabled 1
citadel_trooper_outline_enabled 0
citadel_unit_status_allies_see_thru_walls_max_distance 40
citadel_unit_status_delta_decay_delay 0
citadel_unit_status_delta_decay_rate 10
citadel_unit_status_old_update_rate 15
citadel_unit_status_use_new 0
citadel_use_pvs_for_players 1
citadel_use_vertical_healthbars 0

// === CL === //

cl_autohelp 0
cl_batch_entity_list_ops_during_latch 1
cl_burninggibs 0
cl_clean_textures_on_death 1
cl_detaildist 1
cl_detailfade 0
cl_disable_ragdolls 1
cl_disablefreezecam 0
cl_disconnect_soundevent citadel.convar.stop_all_game_layer_soundevents
cl_drawmonitors 0
cl_ejectbrass 0
cl_eye_yaw_multiplier 0
cl_fasttempentcollision 999999
cl_globallight_shadow_mode 0
cl_glow_brightness 0
cl_impacteffects 0
cl_input_enable_raw_keyboard 1
cl_interp_parallel 1
cl_interp_ratio 0
cl_joystick_enabled 0
cl_lagcompensation 1
cl_maxrenderable_dist 4800
cl_modifier_parallel_gather_status_effect_updates 1
cl_new_impact_effects 0
cl_parallel_readpacketentities 1
cl_parallel_readpacketentities_threshold 4
cl_playerspraydisable 1
cl_ragdoll_collide 0
cl_ragdoll_default_scale 0
cl_ragdoll_limit 0
cl_resend 15
cl_retire_low_priority_lights 1
cl_show_bloodspray 0
cl_show_splashes 0
cl_showerror 0
cl_showhelp 0
cl_simulate_dormant_entities 0
cl_smooth 1
cl_smoothtime 0.25
cl_smooth_draw_debug 0
cl_threaded_bvs 0
cl_threaded_client_leaf_system 1
cl_tickpacket_desired_queuelength 0
cl_tickpacket_recvmargin_desired 5

// === CLOTH === //

cloth_filter_transform_stateless 0
cloth_sim_on_tick 0
cloth_update 1

// === CPU === //

cpu_level 2

// === CQ === //

cq_buffer_bloat_msecs_max 120

// === CSM === //

csm_cascade0_override_dist 0
csm_cascade1_override_dist 0
csm_cascade2_override_dist 0
csm_cascade3_override_dist 0
csm_max_dist_between_caster_and_receiver 0
csm_max_num_cascades_override 0
csm_max_shadow_dist_override 1500
csm_max_visible_dist 0
csm_res_override_0 1
csm_res_override_1 1
csm_res_override_2 1
csm_res_override_3 1
csm_viewmodel_max_shadow_dist 0
csm_viewmodel_shadows 0

// === DISABLE === //

disable_source_soundscape_trace 1

// === DISP === //

disp_dynamic 0

// === DSP === //

dsp_slow_cpu 1
dsp_volume 0

// === ENABLE === //

enable_priority_boost 1

// === ENGINE === //

engine_low_latency_sleep_after_client_tick 1
engine_max_ticks_to_simulate 16
engine_no_focus_sleep 20

// === FAST === //

fast_fogvolume 1

// === FILESYSTEM === //

filesystem_buffer_size 131072
filesystem_max_stdio_read 16
filesystem_native 1

// === FLEX === //

flex_rules 0
flex_smooth 0

// === FOG === //

fog_enable 0
fog_enableskybox 0

// === FPS === //

fps_max 0
fps_max_ui 120

// === FUNC === //

// func_break_max_pieces 0

// === FX === //

fx_drawimpactdebris 0
fx_drawimpactdust 0
fx_drawmetalspark 0

// === G === //

g_debug_ragdoll_visualize 0
g_ragdoll_fadespeed 0
g_ragdoll_important_maxcount 1
g_ragdoll_lifetime 0
g_ragdoll_lvfadespeed 0
g_ragdoll_maxcount 1

// === GPU === //

gpu_level 1
gpu_mem_level 1

// === HOST === //

host_flush_threshold 0
host_thread_mode 0

// === HUD === //

hud_free_cursor 0

// === IMGUI === //

imgui_debug_draw_dashboard_window 0
imgui_enable 0
imgui_enable_input 0
imgui_temp_enable 0

// === IN === //

in_button_double_press_window 0.3
in_usekeyboardsampletime 0

// === INPUT === //

input_virtualization_block_mouse 1

// === IV === //

iv_parallel_latch 1
iv_parallel_restore 1
iv_wrapped_parallel_latch 1

// === LB === //

lb_barnlight_shadow_use_precomputed_vis 0
lb_barnlight_shadowmap_scale 0
lb_csm_cascade_size_override 1
lb_csm_cross_fade_override 0
lb_csm_distance_fade_override 0
lb_csm_draw_alpha_tested 0
lb_csm_draw_translucent 0
lb_csm_override_staticgeo_cascades 0
lb_csm_override_staticgeo_cascades_value 0
lb_csm_receiver_plane_depth_bias 0.00002
lb_csm_receiver_plane_depth_bias_transmissive_backface 0.0002
lb_cubemap_normalization_max 1
lb_cubemap_normalization_roughness_begin 0.01
lb_dynamic_shadow_penumbra 0
lb_dynamic_shadow_resolution 0
lb_dynamic_shadow_resolution_base 32
lb_dynamic_shadow_resolution_quantization 64
lb_enable_baked_shadows 1
lb_enable_dynamic_lights 0
lb_enable_fog_mixed_shadows 0
lb_enable_lights 0
// lb_enable_shadow_casting 0
lb_enable_stationary_lights 1
lb_enable_sunlight 0
lb_max_visible_barn_lights_override 1
lb_max_visible_envmaps_override 4
lb_mixed_shadows 0
lb_precomputed_shadowmap_enable 0
lb_ssss_samples 1

// === LZMA === //

lzma_persistent_buffer 1

// === M === //

m_mouseaccel1 0
m_mouseaccel2 0
m_mousespeed 0
m_rawinput 1

// === MAT === //

mat_aaquality 0
mat_antialias 0
mat_async_shader_load 1
mat_auto_reduce_materials 1
mat_auto_reduce_quality 1
mat_autoexposure_max 0
mat_autoexposure_min 0
mat_bloom_scalefactor_scalar 0
mat_bloomscale 0
mat_bufferprimitives 1
mat_bumpmap 0
mat_clipz 1
mat_colcorrection_disableentities 0
mat_colorcorrection 1
mat_compressedtextures 1
mat_debugdepthval 0
mat_debugdepthvalmax 0
mat_diffuse 1
mat_disable_bands 1
mat_disable_bloom 1
mat_disable_distortion 1
mat_disable_fancy_alpha 1
mat_disable_fancy_blending 1
mat_disable_lightwarp 1
mat_disable_phong 1
mat_disable_rimlight 1
mat_disable_software_led 1
mat_disable_water 1
mat_dynamic_tonemapping 0
mat_enable_uber_shaders 1
mat_envmapsize 0
mat_envmaptgasize 0
mat_fastspecular 1
mat_filterlightmaps 0
mat_filtertextures 0
mat_force_bloom 0
mat_force_tonemap 0
mat_forceaniso 0
mat_forcemanagedtextureintohardware 0
mat_framebuffercopyoverlaysize 0
mat_grain_enable 0
mat_hdr_enabled 0
mat_hdr_level 0
mat_max_lighting_complexity 1
mat_max_worldmesh_vertices 0
mat_maxframelatency 0
mat_mip_linear 0
mat_mipmaptextures 1
mat_motion_blur_enabled 0
mat_non_hdr_bloom_scalefactor 0
mat_parallaxmap 1
mat_phong 0
mat_picmip 3
mat_postprocess_enable 0
mat_postprocessing_combine 1
mat_powersavingsmode 0
mat_queue_mode -1
mat_reducefillrate 1
mat_refraction_quality 0
mat_requires_rt_alloc_first 0
mat_set_shader_quality 0
mat_shadowstate 0
mat_software_aa_blur_one_pixel_lines 0
mat_software_aa_strength 0
mat_software_aa_strength_vgui 0
mat_software_aa_tap_offset 0
mat_softwarelighting 0
mat_specular 0
mat_texture_limit -1
mat_tonemap_bloom_scale 0
mat_tonemapping_occlusion_use_stencil 1
mat_trilinear 0
mat_use_compressed_hdr_textures 1
mat_viewportscale 0.01
mat_wateroverlaysize 0

// === MEM === //

mem_level 1

// === MESH === //

mesh_calculate_curvature_smooth_pass_count 0

// === MINIMAP === //

minimap_update_rate_hz 30

// === MM === //

mm_idle_enabled 0
mm_idle_show_warning_at_s 999

// === MOD === //

mod_forcedata 0
mod_forcetouchdata 0
mod_load_mesh_async 0
mod_load_vcollide_async 0
mod_touchalldata 0

// === MP === //

mp_usehwmmodels 0
mp_usehwmvcds 0

// === NAV === //

nav_obstruction_async_update 1
nav_pathfind_multithread 1

// === NET === //

net_async_clientconnect 1
net_skip_redundant_change_callbacks 1

// === PANORAMA === //

panorama_allow_transitions 0
panorama_async_compute_mipgen 1
panorama_classes_perf_warning_threshold_ms 0.75
panorama_composition_atlas 1
panorama_disable_blur 1
panorama_disable_box_shadow 1
panorama_disable_parallax 1
panorama_disable_render_target_cache 0
panorama_disable_text_shadow 1
panorama_joystick_enabled 0
panorama_js_minidumps 1
panorama_max_fps 15
panorama_max_overlay_fps 15
panorama_skip_composition_layer_content_paint 1
panorama_temp_comp_layer_min_dimension 128
panorama_transition_time_factor 1
panorama_use_new_occlusion_invalidation 1

// === PRESETTLE === //

presettle_cloth_iterations 0

// === PROPS === //

props_break_apply_radial_forces 0
props_break_max_pieces_perframe 2
props_break_radial_force_ratio 0

// === R === //

r_3dsky 0
r_AirboatViewDampenDamp 1
r_AirboatViewDampenFreq 7
r_AirboatViewZHeight 0
r_JeepViewDampenDamp 1
r_JeepViewDampenFreq 7
r_JeepViewZHeight 10
r_RainAllowInSplitScreen 0
r_add_views_in_pre_output 0
r_allow_low_gpu_memory_mode 1
r_allow_onesweep_gpusort 1
r_always_render_all_windows 0
r_ambientboost 0
r_ambientfactor 0
r_ambientmin 0
r_aoproxy_min_dist 9999
r_aoproxy_min_dist_box 9999
r_arealights 0
r_aspectratio 2.3
r_async_compute_fog 1
r_async_shader_compile_notify_frequency 999
r_bloomtintb 0
r_bloomtintexponent 0
r_bloomtintg 0
r_bloomtintr 0
r_cache_pool_allocations 1
r_character_decal_monitor_draw_frustum 0
r_character_decal_monitor_emissive 0
r_character_decal_monitor_render_res 64
r_character_decal_resolution 32
r_cheapshadows 1
r_cheapwaterend 2000
r_cheapwaterstart 1
r_citadel_antialiasing 0
r_citadel_clip_sphere_min_opacity 0
r_citadel_depth_prepass_dynamic_objects 0
r_citadel_depthoffield_enable 0
r_citadel_disable_npr_lighting 0
r_citadel_distancefield_ao_quality 0
r_citadel_distancefield_blur 0
r_citadel_distancefield_down_sample 6
r_citadel_distancefield_farfield_enable 0
r_citadel_distancefield_reflections 0
r_citadel_distancefield_shadows 0
r_citadel_enable_pano_world_blur 0
r_citadel_fog_quality 0
r_citadel_fsr_enable_mip_bias 1
r_citadel_glow_health_bars 0
r_citadel_half_res_noisy_effects 1
r_citadel_motion_blur 0
r_citadel_npr_force_solid_outline 0
r_citadel_npr_outlines 0
r_citadel_npr_outlines_max_dist 600
r_citadel_outlines 0
r_citadel_selection_outline2_alpha 0.2
r_citadel_shadow_quality 0
r_citadel_shadowdb 256
r_citadel_ssao_bent_normals 0
r_citadel_ssao_denoise_passes 0
r_citadel_ssao_quality 0
r_citadel_ssao_radius 0
r_citadel_ssao_thin_occluder_compensation 0
r_citadel_sun_shadow_slope_scale_depth_bias 1.0
r_dashboard_render_quality 0
r_debug_precipitation 0
r_decals 1
r_decals_default_fade_duration 1
r_decals_default_start_fade 0.001
r_decals_max_on_deformables 0
r_decals_overlap_threshold 5
r_decalstaticprops 1
r_deferred_additive_pass 0
r_deferred_height_fog 0
r_deferred_simple_light 0
r_deferred_specular 0
r_deferred_specular_bloom 0
r_depth_of_field 0
r_detailpropfade 0
r_directional_lightmaps 0
r_directlighting 0
r_displacement_mapping 0
r_distancefield_enable 0
r_dof_override 0
r_dopixelvisibility 1
r_draw3dskybox 0
r_draw_batches 0
r_draw_instances 1
r_drawbatchdecals 1
r_drawdecals 1
r_drawdetailprops 0
r_drawdevvisualizers 0
r_drawflecks 0
r_drawfoliage 0
r_drawmodeldecals 0
r_drawopaquestaticpropslast 1
r_drawpixelvisibility 0
r_drawropes 0
r_drawskybox 0
r_drawtracers 0
r_drawtracers_firstperson 0
r_drawtranslucentrenderables 0
r_drawtranslucentworld 0
r_drawwater 0
r_dynamic 0
r_dynamic_light_compile 0
r_effects_bloom 0
r_enable_cubemap_fog 0
r_enable_gradient_fog 0
r_enable_volume_fog 0
r_entityclips 1
r_environment_map_roughness_range 0.01
r_eyegloss 0
r_eyemove 0
r_eyes 0
r_farz 8000
r_fastzreject 0
r_filmgrain 0
r_flashlightambient 0
r_flashlightbrightness 0
r_flashlightdepthtexture 0
r_flashlightdrawfrustum 0
r_flashlightfar 0
r_flashlightfov 90
r_flashlightlinear 0
r_flashlightmodels 0
r_flashlightrender 0
r_flashlightshadowatten 0
r_flashlightshadows 0
r_flex 0
r_fog_enable 0
r_force_thick_hair 0
r_force_zprepass 0
r_forcewaterleaf 1
r_frame_sync_enable 0
r_fullscreen_gamma 1.4
r_gbuffer_disable_npr_lighting 1
r_glint_procedural 0
r_grass_allow_flattening 1
r_grass_density_mode 0
r_grass_end_fade 0
r_grass_quality 0
r_grass_start_fade 0
r_grass_vertex_lighting 1
r_hair_ao 0
r_hair_indirect_transmittance 0
r_hair_meshshader 0
r_hair_shadowtile 0
r_hunkalloclightmaps 0
r_lensflare 0
r_light_flickering_enabled 0
r_light_sensitivity_mode 1
r_light_static 1
r_lightaverage 0
r_lightcache_zbuffercache 1
r_lighting_only 0
r_lightmap_bicubic_filtering 1
r_lightmap_size 4
r_lightmap_size_directional_irradiance 0
r_low_latency 1
r_mapextents 7000
r_max_portal_render_targets 2
r_maxdlights 0
r_maxmodeldecal 1
r_maxnewsamples 0
r_maxsampledist 0
r_minnewsamples 0
r_mipgen_compute_shader 1
r_model_lighting_simplified 1
r_monitor_3dskybox 0
r_morphing_enabled 0
r_multiscattering 1
r_muzzleflashbrightness 0.01
r_occlusion 0
r_occlusionspew 0
r_opaque 1
r_pipeline_stats_use_flush_api 0
r_pixelvisibility_partial 0
r_pixelvisibility_spew 0
r_post_bloom 0
r_postprocess_enable 0
r_propsmaxdist 400
r_queued_decals 1
r_queued_post_processing 0
r_queued_ropes 1
r_render_decals 0
r_render_hair 0
r_render_portals 1
r_renderdoc_auto_shader_pdbs 0
r_renderoverlayfragment 0
r_rendersun 0
r_reset_character_decals 1
r_rope_holiday_light_scale 0
r_ropes_holiday_lights_allowed 0
r_ropetranslucent 0
r_screen_space_shadows 0
r_screenoverlay 0
r_screenspace_aa 0
r_shadow_distance 0
r_shadow_half_update_rate 1
r_shadowmaxrendered 0
r_shadowrendertotexture 0
r_shadows 0
r_shadowtile_waveops 0
r_show_gpu_memory_visualizer 0
r_showdebugrendertarget 0
r_showsunshadowdebugrendertargets 0
r_showsunshadowdebugsplitvis 0
r_smooth_morph_normals 0
r_ssao 0
r_ssao_blur 0
r_ssao_strength 0
r_strip_invisible_during_sceneobject_update 1
r_suppress_redundant_state_changes 1
r_teeth 0
r_texture_anisotropic 4
r_texture_budget_dynamic 1
r_texture_budget_threshold 0.8
r_texture_budget_update_period 0.1
r_texture_filter_textures 0
r_texture_nonstreaming_load 1
r_texture_pool_reduce_rate 512
r_texture_pool_size 512
r_texture_stream_lowres_drop_rate 6
r_texture_stream_max_resolution 1024
r_texture_stream_mip_bias 4
r_texture_stream_mip_skip 1
r_texture_stream_pool_budget 2048
r_texture_stream_resolution_bias 0.1
r_texture_streaming 1
r_texturefilteringquality 0
r_threaded_client_shadow_manager 0
r_threaded_renderables 1
r_threaded_scene_object_update 1
r_threaded_shadow_clip 0
r_translucent 1
r_translucent_sort_policy 0
r_use_memory_budget_model 1
r_vma_defrag_enabled 1
r_waterdrawreflection 0
r_waterdrawrefraction 0
r_waterforceexpensive 0
r_waterforcereflectentities 0
r_world_wind_frequency_grass 0
r_world_wind_frequency_trees 0
r_world_wind_strength 0
r_worldlights 0
r_worldlistcache 1

// === RAGDOLL === //

ragdoll_lru_debug_removal 0
ragdoll_parallel_pose_control 1

// === RESET === //

reset_voice_on_input_stallout 0

// === ROPE === //

rope_averagelight 0
rope_collide 0
rope_rendersolid 0
rope_shake 0
rope_smooth 0
rope_smooth_enlarge 0
rope_smooth_maxalpha 0
rope_smooth_maxalphawidth 0
rope_smooth_minalpha 0
rope_smooth_minwidth 0
rope_solid_minalpha 0
rope_solid_minwidth 0
rope_subdiv 0
rope_wind_dist 0

// === SAVE === //

save_parallel 1

// === SC === //

sc_aggregate_bvh_threshold 128
sc_aggregate_indirect_draw_compaction 1
sc_aggregate_indirect_draw_compaction_threshold 16
sc_cache_envmap_lpv_lookup 1
sc_clutter_density_full_size 0.5
sc_clutter_density_none_size 0.1
sc_clutter_enable 0
sc_disable 0
sc_disable_baked_lighting 0
sc_disable_shadow_materials 1
sc_disable_spotlight_shadows 1
sc_enable_discard 1
sc_fade_distance_scale_override 10
sc_force_materials_batchable 1
sc_hdr_enabled_override 0
sc_instanced_mesh_mesh_shader 0
sc_instanced_mesh_motion_vectors 0
sc_instanced_mesh_opaque_fade 0
sc_layer_batch_threshold 128
sc_layer_batch_threshold_fullsort 80
sc_max_framebuffer_copies_per_layer 0

// === SHOW === //

show_visibility_boxes 0

// === SND === //

snd_async_fullyasync 1
snd_defer_trace 1
snd_envelope_rate 100.0
snd_event_browser_default_stack citadel_default_3d
snd_event_browser_focus_events 1
snd_event_cone_debug 0
snd_mix_async 1
snd_mixahead 0.025
snd_noextraupdate 1
snd_occlusion_bounces 0
snd_occlusion_debug 0
snd_occlusion_rays 0
snd_pitchquality 0
snd_report_audio_nan 1
snd_sos_max_event_base_depth 10
snd_sound_areas_debug 0
snd_soundmixer Default_Mix
snd_soundmixer_update_maximum_frame_rate 0
snd_soundmixer_version 1
snd_spatialize_lerp 0
snd_steamaudio_active_hrtf 0
snd_steamaudio_enable_custom_hrtf 0
snd_steamaudio_enable_pathing 0
snd_steamaudio_enable_perspective_correction 0
snd_steamaudio_enable_reverb 0
snd_steamaudio_invalid_path_length 0.0
snd_steamaudio_ir_duration 1.0
snd_steamaudio_load_pathing_data 0
snd_steamaudio_load_reverb_data 0
snd_steamaudio_num_threads 4
snd_steamaudio_reverb_order_rendering 0
snd_steamaudio_reverb_update_rate 10.0
snd_ui_positional 0
snd_ui_spatialization_spread 2.4
snd_use_baked_occlusion 1

// === SOS === //

sos_use_guid_filter 1

// === SOUNDSYSTEM === //

soundsystem_update_async 1

// === SPARSESHADOWTREE === //

sparseshadowtree_disable_for_viewmodel 0
sparseshadowtree_enable_rendering 1
sparseshadowtree_parallel_generation 2

// === SPEAKER === //

speaker_config {'min': '0', 'default': '0', 'max': '2'}

// === SV === //

sv_hide_ent_in_pvs 1
sv_lagcomp_filterbyviewangle 0
sv_maxunlag 0.500
sv_maxunlag_player 0.200
sv_minrate 98304
sv_parallel_sendsnapshot 2
sv_pvs_max_distance 2800
sv_remove_ent_from_pvs 1
sv_waterdist 0

// === SYS === //

sys_minidumpspewlines 0

// === THINK === //

think_limit 5

// === THUMPER === //

thumper_use_plane_reflection 0

// === TRACER === //

tracer_extra 0

// === UPDATE === //

update_voices_low_priority 1

// === VIOLENCE === //

violence_ablood 0
violence_agibs 0
violence_hblood 0
violence_hgibs 0

// === VIS === //

vis_sunlight_enable 0

// === VOICE === //

voice_always_sample_mic {'version': '2', 'default': '0'}
voice_buffer_ms 200
voice_in_process 1
voice_input_stallout 0.5
voice_steal 2

// === VOLUME === //

volume_fog_intermediate_textures_hdr 0

// === WIND === //

wind_system_default_resolution_xy 64
wind_system_temporal_smoothing 0

// === ZIPLINE === //

zipline_use_new_latch 0

        "rate"
        {
            "min"       "98304"
            "default"   "786432"
            "max"       "1000000"
        }
        "sv_minrate"    "98304"
        "sv_maxunlag"   "0.500"
        "sv_maxunlag_player" "0.200"
        "sv_lagcomp_filterbyviewangle" "false"

        // Spew warning when adding/removing classes to/from the top of the hierarchy
        "panorama_classes_perf_warning_threshold_ms" "0.75"

        // Panorama - enable minidumps on JS exceptions
        "panorama_js_minidumps" "1"
        // Enable the render target cache optimization.
        "panorama_disable_render_target_cache" "0"

        // Enable the composition layer optimization
        "panorama_skip_composition_layer_content_paint" "1"

        // too expensive (500MB+) to load this
        "snd_steamaudio_load_reverb_data" "0"
        "snd_steamaudio_load_pathing_data" "0"

        // Steam Audio project specific convars
        "snd_steamaudio_enable_custom_hrtf"     "0"
        "snd_steamaudio_active_hrtf"            "0"
        "snd_steamaudio_reverb_update_rate"     "10.0"
        "snd_steamaudio_ir_duration"            "1.0"
        "snd_steamaudio_enable_pathing"         "0"
        "snd_steamaudio_invalid_path_length"    "0.0"
        "cl_disconnect_soundevent"              "citadel.convar.stop_all_game_layer_soundevents"
        "snd_event_browser_default_stack"       "citadel_default_3d"
        
        // voip
        "voice_in_process"                      "1"

        // Sound debugging
        "snd_report_audio_nan" "1"

        // Audio system settings
        "snd_sos_max_event_base_depth" "10"
        "sos_use_guid_filter" "1"

        "voice_always_sample_mic"               
        {
            "version"   "2"
            "default"   "0"
        }

        "reset_voice_on_input_stallout"         "0"
        "voice_input_stallout"                  "0.5"
        "cl_usesocketsforloopback" "1"
        "cl_poll_network_early" "0"

        // Perf/Parallelism
        "iv_parallel_restore" "1"

        // For perf reasons, since we don't use source-based DSP:
        "disable_source_soundscape_trace"       "1"
        
        // Networking - Induced latency (pred offset)
        "cl_tickpacket_recvmargin_desired" "5"                  // 5 ms base, min. floor for protecting against thrashing the queue
        "cl_tickpacket_desired_queuelength" "0"                 // 0 = attempt to always reach the queue's min floor
        "cl_async_usercmd_send_disabled_recvmargin_min" "0.5"   // Additional frame since we do not use the async usercmd send (potentially unneccessary)
        "cl_clock_buffer_ticks" "1"
        "cl_interp_ratio" "0"
        "cl_async_usercmd_send" "true"

        "fps_max_ui"    "120"

        "in_button_double_press_window" "0.3"

        // Convars that control spatialization of UI audio.
        "snd_ui_positional"                             "false"
        "snd_ui_spatialization_spread"                  "2.4"
        
        // sound volume rate change limiting
        "snd_envelope_rate"                             "100.0"
        "snd_soundmixer_update_maximum_frame_rate"      "0"

        //don't let people mess with speaker config settings.
        "speaker_config"
        {
            "min"       "0"
            "default"   "0"
            "max"       "2"
        }

        "cq_buffer_bloat_msecs_max" "120"

        "snd_soundmixer"                        "Default_Mix"
        "cloth_filter_transform_stateless" "0"

        "cl_joystick_enabled" "0"
        "panorama_joystick_enabled" "0"

        "snd_event_browser_focus_events" "true"

        "cl_max_particle_pvs_aabb_edge_length" "100"
        
        // Allow aggregation of particles (for perf)
        "cl_aggregate_particles" "true"
        
        "citadel_enable_vdata_sound_preload" "true"
    }

    Memory
    {
        "EstimatedMaxCPUMemUsageMB" "1"
        "EstimatedMinGPUMemUsageMB" "1"

        "ShowInsufficientPageFileMessageBox" "1"
        "ShowLowAvailableVirtualMemoryMessageBox" "1"
    }
}
