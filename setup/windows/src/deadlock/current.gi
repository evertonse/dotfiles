"GameInfo"
{
	game 		"citadel"
	title 		"Citadel"
	type		multiplayer_only
	nomodels 1
	nohimodel 1
	nocrosshair 0
	hidden_maps
	{
		"test_speakers"			1
		"test_hardware"			1
	}
	nodegraph 0
	perfwizard 0
	tonemapping 0 
	GameData	"citadel.fgd"
	
	Localize
	{
		DuplicateTokensAssert	1
		DisallowTokenContexts	1
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
		SearchPaths
		{
			// These are optional language paths. They must be mounted first, which is why there are first in the list.
			// *LANGUAGE* will be replaced with the actual language name. If not running a specific language, these paths will not be mounted
			Game_Language		citadel_*LANGUAGE*

			// These are optional low-violence paths. They will only get mounted if you're in a low-violence mode.
			Game_LowViolence	citadel_lv

			Mod					citadel
			Write				citadel
			Game				citadel/addons
			Game				citadel
			Game				core
		}
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
			FakeLag			0
			FakeLoss		0
			//FakeReorderPct 0.05
			//FakeReorderDelay 10
			//FakeJitter "low"
			// Turning off fake jitter for now while I work on making the CQ totally solid
			FakeReorderPct 0
			FakeReorderDelay 0
			FakeJitter "off"
		}

		"UseSerializedEntityPool" "1"
		"SkipRedundantChangeCallbacks"	"1"
	}

	RenderSystem
	{
		IndexBufferPoolSizeMB 32
		VertexBufferPoolSizeMB 32
		UseReverseDepth 1
		Use32BitDepthBuffer 0
		Use32BitDepthBufferWithoutStencil 0
		SwapChainSampleableDepth 1
		VulkanMutableSwapchain 1
		"LowLatency"								"1"
		"VulkanOnly"								"1"	[ $LINUX || $OSX ] // No OpenGL or D3D9/11 fallback on Linux or OSX, only Vulkan is supported.
		"VulkanRequireSubgroupWaveOpSupport"		"1"	[ !$OSX ]
		"VulkanRequireDescriptorIndexing"			"1"	[ !$OSX ]
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
		ReflexLateWarp 1
	}

	Engine2
	{
		HasModAppSystems 1
		Capable64Bit 1
		URLName citadel
		RenderingPipeline
		{
			SupportsMSAA 0
			DistanceField 0
			AmbientOcclusionProxies 0
		}
		PauseSinglePlayerOnGameOverlay 1
		DefensiveConCommands 1
		DisableLoadingPlaque 1
		AllowKeyChordBindings 0
		LightmapUVQuery 0
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
		HierarchicalEncodingFiles	 "1"
	}

	ToolsEnvironment
	{
		"Engine"	"Source 2"
		"ToolsDir"	"../sdktools"	// NOTE: Default Tools path. This is relative to the mod path.
	}
	
	pulse
	{
		"pulse_enabled"					"1"
	}

	Hammer
	{
		"fgd"					"citadel.fgd"	// NOTE: This is relative to the 'game' path.
		"GameFeatureSet"		"Citadel"
		"DefaultSolidEntity"	"trigger_multiple"
		"DefaultPointEntity"	"info_player_start"
		"NavMarkupEntity"		"func_nav_markup"
		"OverlayBoxSize"			"8"
		"TileMeshesEnabled"			"1"
		"RenderMode"				"ToolsVis"
		"CreateRenderClusters"		"1"
		"DefaultMinDrawVolumeSize"	"2048"
		"DefaultMinTrianglesPerCluster"	"16384"
		"TileGridSupportsBlendHeight"	"1"
		"TileGridBlendDefaultColor"	"0 255 0"
		"LoadScriptEntities" "0"
		"UsesBakedLighting" "1"
		"UseAnalyticGrid" "0"
		"SupportsDisplacementMapping" "0"
		"SteamAudioEnabled"				"1"
		"LatticeDeformerEnabled"		"1"
		"ShadowAtlasWidth" "0"
		"ShadowAtlasHeight" "0"
		"TimeSlicedShadowMapRendering" "0"
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
			"bakedlighting"	"1"	// Enable lightmapping during compile time		
			"envmap"	"0" // turned off since it currently causes an assert and doesn't work due to some build issue
			"nav"		"1"	// Generate nav mesh data
		}

		MeshCompiler
		{
			OptimizeForMeshlets 1
			TrianglesPerMeshlet 64	// Maximum valid value currently is 126
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
			UseAggregateInstances				"1"
			AggregateInstancingMeshlets			"1"
			BakePropsWithExtraVertexStreams		"1"
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
				GridSpacing			"3.0"
				HeightAboveFloor	"1.5"
				RebakeOption		"0"						// 0: cleanup, 1: manual, 2: auto
				NumRays				"32768"
				NumBounces			"64"
				IRDuration			"1.0"
				AmbisonicsOrder		"1"
			}
			PathingDefaults
			{
				GridSpacing			"3.0"
				HeightAboveFloor	"1.5"
				RebakeOption		"0"						// 0: cleanup, 1: manual, 2: auto
				NumVisSamples		"1"
				ProbeVisRadius		"0"
				ProbeVisThreshold	"0.1"
				ProbeVisPathRange	"1000.0"
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
			GameOutputPath	"resource/localization/citadel_vdata"
			TokenPrefix		"Citadel_VData_"
		}
		
		TextureCompiler
		{
			//Compressor              "lz4"
			//CompressMipsOnDisk      "1"
			//CompressMinRatio        "95"
			AllowNP2Textures		"1"
			AllowPanoramaMipGeneration	"1"
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
		EnvironmentMaps					1
		EnvironmentMapFaceSize			256
		EnvironmentMapRenderSize		1024
		EnvironmentMapFormat			BC6H
		EnvironmentMapPreviewFormat 		BC6H
		EnvironmentMapColorSpace		linear
		EnvironmentMapMipProcessor		GGXCubeMapBlur
		// Build cubemaps into a cube array instead of individual cubemaps.
		"EnvironmentMapUseCubeArray" 	1
		"EnvironmentMapCacheSizeTools"  300
		BindlessSceneObjectDesc			CitadelBindlessDesc
		GrassCastsShadows				0
		LPVEdgeBlending 0
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
		TransformTextureRowCount	1024
		TransformTextureRowCountToolsMode 6144
		SunLightMaxCascadeSize		2
		SunLightShadowRenderMode	Depth
		LayerBatchThresholdFullsort 128
		NonTexturedGradientFog		0
		// Temp till I can add support in citadel shaders
		DisableLateAllocatedTransformBuffer 1
		MinimumLateAllocatedVertexCacheBufferSizeMB 64
		CubemapFog 0
		VolumetricFog 0
		FrameBufferCopyFormat R11G11B10F
		Tonemapping 0
		CMTAtlasWidth 512
		CMTAtlasHeight 256
		CharacterDecals 0
		HDRFrameBuffer 0
		SupportsInstancedFade 1
		GpuLightBinnerSupportViewModelCascade 1
		ParticleBufferSize 256
		ShadowmapMaxFilterRadius 0
		FogCachedShadowTileMaxFilterRadius 0
		PointLightShadowsEnabled 0
		PunctualContactShadows 0
		
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
		"DisableServerInterpCompensation"	"1"
		"DisableAnimationScript" 	"1"
		"ServerPoseRecipeHistorySize"	"60"
		"ClientPoseRecipeHistorySize"	"60"

	}

	ModelDoc
	{
		"models_gamedata"			"models_gamedata.fgd"
		"features"					"animgraph;modelconfig;gamepreview;wireframe_backfaces;distancefield"
	}

	Particles
	{
		"EnableParticleShaderFeatureBranching"	"1"
		"Float16HDRBackBuffer" "1"
		"PET_SupportFadingOpaqueModels" "1"
		"Features" "non_homogenous_forward_layer_only"
		"ParticleTraceOffsetOnlyHit" "1"
		"ParticlesFoggedByDefault" "0"
	}

	ConVars
	{

//=====================================================================================
// README:
// https://docs.comfig.app/latest/tf2/misconceptions/#bad-cvars
//      This config tries to optimize memory contention from cpu because I only have 1 stick of ram DDR4 32gb 32mhz
//      The CPU is Ryzen 5 4600g and GPU is 1660 GTX. So we try to sacrifice GPU to help the low end CPU and RAM usage
//      the GPU is usually not the bottleneck as long as we're using under 6G VRAM
//=====================================================================================
// +exec autoexec.cfg  -convars_visible_by_default -dev -dx11 -no_environment_maps -novid -noassert -nojoy  -high +@panorama_min_comp_layer_cache_cost_TURNED_OFF 256 
// +exec autoexec.cfg -dx11 -novid -noassert -nojoy  +@panorama_min_comp_layer_cache_cost_TURNED_OFF 256
// CS 1.6 https://gist.github.com/LeBaux/27223336ed5a44529208e8e17c63e0c1
// -dev -convars_visible_by_default -novid -noassert -nojoy 
// [QOL-2-2-3]:Aig0SxQjZMhMDi8lk6khZCADh4clKBQCQEEGkIyigGVkZIxYQjZiCZlkAKBQwBgigwyAjCAcWVoyAicDycHjwRJLsMQShweZM4ADAIAMMmTQyJDJUPKBASXDkkwi
//
// Auto updated CVARLIST https://github.com/Mikooboy/deadlock-cvar-list/blob/main/cvarlist.md
//=====================================================================================

//>>> ================ INPUT ================
// m_rawinput  1
// m_filter 0                            // Disables mouse smoothing, improves responsiveness
cl_input_enable_raw_keyboard 1
cl_showerror 0
//<<< ================ INPUT ================

// === ANIMATION === //
anim_decode_forcewritealltransforms 1
anim_disable 1
animgraph_enable_parallel_op_evaluation 1
animgraph_enable_parallel_preupdate 1
animgraph_footlock_enabled 0
animgraph_slowdownonslopes_enabled 0
citadel_npc_force_animate_every_tick 0
cl_bone_cache_optimization 1
enable_boneflex 0
ik_fabrik_align_chain 0
ik_final_fixup_enable 0
r_enable_rigid_animation 0

// === LOD === //
ai_lod_auto_enabled 1
ai_think_interval_lod_low 1
ai_think_interval_lod_med 0.4
lb_shadow_map_cull_empty_mixed 1
lb_sun_csm_size_cull_threshold_texels 30
r_aoproxy_cull_dist 0.01
r_citadel_gpu_culling_shadows 1
r_fallback_texture_lod_scale 4
r_haircull_percent 100
r_size_cull_threshold 1.6
r_size_cull_threshold_shadow 200
r_texture_lod_scale 4
sc_allow_dithered_lod 0
sc_dithered_lod_transition_amt 0
sc_instanced_mesh_lod_bias 15
sc_instanced_mesh_lod_bias_shadow 10
sc_instanced_mesh_size_cull_bias 10
sc_instanced_mesh_size_cull_bias_shadow 10
sc_screen_size_lod_scale_override 0.001
skeleton_instance_lod_optimization 1

// === NETWORK === //
cl_async_usercmd_send 1
cl_async_usercmd_send_disabled_recvmargin_min 0.5
cl_clock_buffer_ticks 1
cl_poll_network_early 0
cl_usesocketsforloopback 1
rate {'min': '98304', 'default': '786432', 'max': '1000000'}

// === NO PREFIX === //
closecaption 0

// === PARTICLES === //
cl_aggregate_particles 1
cl_max_particle_pvs_aabb_edge_length 100
cl_particle_batch_mode 2
cl_particle_fallback_base 10
cl_particle_fallback_multiplier 10
cl_particle_max_count 0
cl_particle_sim_fallback_base_multiplier 100
cl_particle_sim_fallback_threshold_ms 0
particle_cluster_nodraw 1
particle_cluster_use_collision_hulls 0
r_RainParticleDensity 0
r_citadel_screenspace_particles_full_res 0
r_draw_particle_children_with_parents 0
r_limit_particle_job_duration 1
r_particle_allowprerender 0
r_particle_batch_collections 1
r_particle_cables_cast_shadows 0
r_particle_cables_render 1
r_particle_cables_render_meshlets 0
r_particle_max_detail_level 1 
r_particle_max_draw_distance 300000
r_particle_max_size_cull 1600
r_particle_max_texture_layers 3
r_particle_min_timestep 0.001
r_particle_mixed_resolution_viewstart 800
r_particle_model_new8 0
r_particle_model_per_thread_count 48
r_particle_skip_postsim 1

// === PHYSICS === //
cl_phys_enabled 0
cl_phys_networked_start_sleep 1
cl_phys_sleep_enable 1
cl_phys_timescale 1
cl_physics_highlight_active 0
phys_cull_internal_mesh_contacts 1
phys_dynamic_scaling 0
phys_expensive_shape_threshold 100
phys_highlight_expensive_objects_strength 0
phys_multithreading_enabled 1
phys_threaded_cloth_bone_update 1
phys_threaded_kinematic_bone_update 1
phys_threaded_transform_update 1
r_physics_particle_op_spawn_scale 0

// === PREDICTION === //
cl_predict_after_every_createmove 0
cl_prediction_savedata_postentitypacketreceived 1
cl_predictioncopy_runs 0
pred_cloth_pos_max 0
pred_cloth_pos_multiplier 0
pred_cloth_pos_strength 0
pred_cloth_rot_high 0
pred_cloth_rot_low 0
pred_cloth_rot_multiplier 0

// === AI === //
ai_async_queue_max_jobs 8
ai_expression_optimization 1
ai_foot_sweep_enable 0
ai_gather_conditions_async 1
ai_strong_optimizations_no_checkstand 1
ai_think_interval 0.3
ai_use_async_ragdoll_fixup 1

// === AUDIO === //
audio_enable_vmix_mastering 0

// === BATTERY === //
battery_saver 0

// === CITADEL === //
citadel_boss_glow_disabled 1
citadel_camera_soft_collision 0
citadel_camera_wobble_disable 1
citadel_cinematic_intro_duration_npc 0
citadel_cinematic_intro_duration_player 0
citadel_cinematic_intro_enabled -1
citadel_crosshair_hit_marker_duration 0
citadel_damage_offscreen_indicator_disabled 1
citadel_damage_text_lifetime 0.5
citadel_damage_text_show_effectiveness 0
citadel_enable_vdata_sound_preload 1
citadel_hideout_ball_show_juggle_count 1
citadel_hideout_ball_show_juggle_fx 1
citadel_hideout_enable_testing_tools 1
citadel_hud_objective_health_enabled 2
citadel_in_world_item_panel_dpi 0.75
citadel_minimap_use_canvas_for_neutrals 0
citadel_minimap_use_canvas_for_shop 0
citadel_npc_disable_cockroaches 1
citadel_per_weapon_per_surface_impact_effects 0
citadel_player_outline_enemies 0
citadel_portrait_world_renderer_off 1
citadel_show_new_damage_feedback_numbers 0
citadel_trooper_friendly_glow_disabled 1
citadel_trooper_glow_disabled 1
citadel_trooper_outline_enabled 0
citadel_unit_status_old_update_rate 15
citadel_unit_status_use_new 0
citadel_use_pvs_for_players 1

// === CL === //
cl_batch_entity_list_ops_during_latch 1
cl_disable_ragdolls 1
cl_disconnect_soundevent citadel.convar.stop_all_game_layer_soundevents
cl_eye_yaw_multiplier 0
cl_fasttempentcollision 999999
cl_globallight_shadow_mode 0
cl_glow_brightness 0
cl_impacteffects 0
cl_input_enable_raw_keyboard 1
cl_interp_parallel 1
cl_interp_ratio 0
cl_joystick_enabled 0
cl_parallel_readpacketentities 1
cl_parallel_readpacketentities_threshold 2
cl_ragdoll_default_scale 0
cl_ragdoll_limit 0
cl_retire_low_priority_lights 1
cl_show_splashes 0
cl_simulate_dormant_entities 0
cl_smooth_draw_debug 0
cl_smoothtime 0.01
cl_tickpacket_desired_queuelength 0
cl_tickpacket_recvmargin_desired 5

// === CLOTH === //
cloth_filter_transform_stateless 0
cloth_sim_on_tick 0
cloth_update 1

// === CPU === //
cpu_level 1

// === CQ === //
cq_buffer_bloat_msecs_max 120

// === CSM === //
csm_cascade0_override_dist 0
csm_cascade1_override_dist 0
csm_cascade2_override_dist 0
csm_cascade3_override_dist 0
csm_max_dist_between_caster_and_receiver 0
csm_max_num_cascades_override 0
csm_max_shadow_dist_override 0
csm_max_visible_dist 0
csm_res_override_0 1
csm_res_override_1 1
csm_res_override_2 1
csm_res_override_3 1
csm_viewmodel_shadows 0

// === DISABLE === //
disable_source_soundscape_trace 1

// === DSP === //
dsp_slow_cpu 1
dsp_volume 0

// === ENABLE === //
enable_priority_boost 1

// === ENGINE === //
engine_low_latency_sleep_after_client_tick 1
engine_max_ticks_to_simulate 33

// === FOG === //
fog_enable 0
fog_enableskybox 0

// === FPS === //
fps_max 0
fps_max_ui 120

// === FUNC === //
func_break_max_pieces 0

// === FX === //
fx_drawmetalspark 0

// === G === //
g_ragdoll_important_maxcount 1
g_ragdoll_maxcount 1

// === GPU === //
gpu_level 1
gpu_mem_level 1

// === HUD === //
hud_free_cursor 0

// === IN === //
in_button_double_press_window 0.3

// === IV === //
iv_parallel_restore 1

// === LB === //
lb_barnlight_shadow_use_precomputed_vis 0
lb_barnlight_shadowmap_scale 0.01
lb_csm_cascade_size_override 0.25
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
lb_dynamic_shadow_resolution_quantization 32
lb_enable_baked_shadows 1
lb_enable_dynamic_lights 0
lb_enable_fog_mixed_shadows 0
lb_enable_lights 0
lb_enable_shadow_casting 0
lb_enable_stationary_lights 0
lb_enable_sunlight 0
lb_max_visible_barn_lights_override 1
lb_mixed_shadows 0
lb_precomputed_shadowmap_enable 0
lb_ssss_samples 0

// === MAT === //
mat_async_shader_load 1
mat_colcorrection_disableentities 0
mat_colorcorrection 0
mat_max_lighting_complexity 1
mat_set_shader_quality 0
mat_tonemap_bloom_scale 0
mat_viewportscale 0.01

// === MESH === //
mesh_calculate_curvature_smooth_pass_count 0

// === MINIMAP === //
minimap_update_rate_hz 30

// === MM === //
mm_idle_show_warning_at_s 999

// === NAV === //
nav_obstruction_async_update 1
nav_pathfind_multithread 1

// === NET === //
net_async_clientconnect 1

// === PANORAMA === //
panorama_allow_transitions 0
panorama_async_compute_mipgen 1
panorama_classes_perf_warning_threshold_ms 0.75
panorama_disable_blur 1
panorama_disable_box_shadow 0
panorama_disable_render_target_cache 0
panorama_joystick_enabled 0
panorama_js_minidumps 1
panorama_max_fps 15
panorama_max_overlay_fps 15
panorama_skip_composition_layer_content_paint 1
panorama_temp_comp_layer_min_dimension 128
panorama_transition_time_factor 2
panorama_use_new_occlusion_invalidation 1

// === PRESETTLE === //
presettle_cloth_iterations 0

// === PROPS === //
props_break_apply_radial_forces 0
props_break_max_pieces_perframe 0

// === R === //
r_aoproxy_min_dist 9999
r_aoproxy_min_dist_box 9999
r_arealights 0
r_async_compute_fog 1
r_character_decal_monitor_render_res 64
r_character_decal_resolution 0.01
r_citadel_antialiasing 0
r_citadel_depth_prepass_dynamic_objects 0
r_citadel_depthoffield_enable 0
r_citadel_disable_npr_lighting 0
r_citadel_distancefield_blur 0
r_citadel_distancefield_down_sample 6
r_citadel_distancefield_farfield_enable 0
r_citadel_distancefield_shadows 0
r_citadel_enable_pano_world_blur 0
r_citadel_fog_quality 0
r_citadel_glow_health_bars 0
r_citadel_npr_force_solid_outline 0
r_citadel_npr_outlines 0
r_citadel_npr_outlines_max_dist 600
r_citadel_shadow_quality 0
r_citadel_shadowdb 256
r_citadel_ssao_bent_normals 0
r_citadel_ssao_denoise_passes 0
r_citadel_ssao_quality 0
r_citadel_ssao_radius 0
r_citadel_ssao_thin_occluder_compensation 0
r_citadel_sun_shadow_slope_scale_depth_bias 1.0
r_dashboard_render_quality 0
r_decals 1
r_decals_default_fade_duration 0.001
r_decals_default_start_fade 0.001
r_decals_max_on_deformables 0
r_decals_overlap_threshold 5
r_depth_of_field 0
r_directional_lightmaps 0
r_directlighting 0
r_distancefield_enable 0
r_dopixelvisibility 1
r_draw3dskybox 0
r_drawdecals 0
r_drawmodeldecals 0
r_drawropes 0
r_drawskybox 1
r_drawtracers 0
r_drawtracers_firstperson 0
r_effects_bloom 0
r_enable_cubemap_fog 0
r_enable_gradient_fog 0
r_enable_volume_fog 0
r_environment_map_roughness_range 0.01
r_farz 6000
r_flashlightbrightness 0
r_flashlightfar 0
r_flashlightshadowatten 0
r_frame_sync_enable 0
r_fullscreen_gamma 1.4
r_grass_end_fade 0
r_grass_quality 0
r_grass_start_fade 0
r_hair_ao 0
r_hair_indirect_transmittance 0
r_hair_shadowtile 0
r_light_flickering_enabled 0
r_light_sensitivity_mode 1
r_lightmap_size 4
r_lightmap_size_directional_irradiance 0
r_low_latency 1
r_mapextents 4500
r_max_portal_render_targets 2
r_monitor_3dskybox 0
r_morphing_enabled 0
r_muzzleflashbrightness 0.01
r_pipeline_stats_use_flush_api 0
r_post_bloom 0
r_postprocess_enable 0
r_propsmaxdist 600
r_render_decals 0
r_render_hair 0
r_renderdoc_auto_shader_pdbs 0
r_rendersun 0
r_ropetranslucent 0
r_shadows 0
r_smooth_morph_normals 0
r_ssao 0
r_ssao_blur 0
r_ssao_strength 0
r_strip_invisible_during_sceneobject_update 1
r_texture_budget_dynamic 1
r_texture_budget_threshold 0.7
r_texture_budget_update_period 0.5
r_texture_nonstreaming_load 1
r_texture_pool_reduce_rate 512
r_texture_pool_size 256
r_texture_stream_max_resolution 128
r_texture_stream_mip_bias 3
r_texture_stream_resolution_bias 0.01
r_texturefilteringquality 0
r_world_wind_frequency_grass 0
r_world_wind_frequency_trees 0
r_world_wind_strength 0

// === RAGDOLL === //
ragdoll_parallel_pose_control 1

// === RESET === //
reset_voice_on_input_stallout 0

// === ROPE === //
rope_collide 0
rope_smooth_enlarge 0
rope_smooth_maxalpha 0
rope_smooth_maxalphawidth 0
rope_smooth_minalpha 0
rope_smooth_minwidth 0
rope_subdiv 0
rope_wind_dist 0

// === SC === //
sc_aggregate_bvh_threshold 16
sc_cache_envmap_lpv_lookup 0
sc_clutter_density_full_size 0.5
sc_clutter_density_none_size 0.1
sc_clutter_enable 0
sc_disable_baked_lighting 1
sc_disable_shadow_materials 1
sc_disable_spotlight_shadows 1
sc_enable_discard 1
sc_fade_distance_scale_override 180
sc_force_materials_batchable 1
sc_hdr_enabled_override 0
sc_instanced_mesh_mesh_shader 0
sc_instanced_mesh_motion_vectors 0
sc_instanced_mesh_opaque_fade 0
sc_layer_batch_threshold 16
sc_layer_batch_threshold_fullsort 20
sc_max_framebuffer_copies_per_layer 0

// === SND === //
snd_envelope_rate 100.0
snd_event_browser_default_stack citadel_default_3d
snd_event_browser_focus_events 1
snd_mix_async 1
snd_mixahead 0.05
snd_occlusion_bounces 0
snd_report_audio_nan 1
snd_sos_max_event_base_depth 10
snd_soundmixer Default_Mix
snd_soundmixer_update_maximum_frame_rate 0
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
snd_steamaudio_reverb_update_rate 10.0
snd_ui_positional 1
snd_ui_spatialization_spread 2.4
snd_use_baked_occlusion 1

// === SOS === //
sos_use_guid_filter 1

// === SOUNDSYSTEM === //
soundsystem_update_async 1

// === SPARSESHADOWTREE === //
sparseshadowtree_disable_for_viewmodel 1
sparseshadowtree_enable_rendering 0
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

// === THINK === //
think_limit 10

// === THUMPER === //
thumper_use_plane_reflection 0

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
voice_in_process 1
voice_input_stallout 0.5

// === VOLUME === //
volume_fog_intermediate_textures_hdr 0

// === WIND === //
wind_system_default_resolution_xy 64
wind_system_temporal_smoothing 0

// === ZIPLINE === //
zipline_use_new_latch 0




// ======================================================================== \\
// ============================ END OF CONFIG  ============================ \\
// ======================================================================== \\

		"rate"
		{
			"min"		"98304"
			"default"	"786432"
			"max"		"1000000"
		}
		"sv_minrate"	"98304"
		"sv_maxunlag"	"0.500"
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
		"snd_steamaudio_enable_custom_hrtf"		"0"
		"snd_steamaudio_active_hrtf"			"0"
		"snd_steamaudio_reverb_update_rate"		"10.0"
		"snd_steamaudio_ir_duration"			"1.0"
		"snd_steamaudio_enable_pathing"			"0"
		"snd_steamaudio_invalid_path_length"	"0.0"
		"cl_disconnect_soundevent"				"citadel.convar.stop_all_game_layer_soundevents"
		"snd_event_browser_default_stack"		"citadel_default_3d"
		
		// voip
		"voice_in_process"			            "1"

		// Sound debugging
		"snd_report_audio_nan" "1"

		// Audio system settings
		"snd_sos_max_event_base_depth" "10"
		"sos_use_guid_filter" "1"

		"voice_always_sample_mic"               
		{
			"version"	"2"
			"default"	"0"
		}

		"reset_voice_on_input_stallout"         "0"
		"voice_input_stallout"                  "0.5"
		"cl_usesocketsforloopback" "1"
		"cl_poll_network_early" "0"

		// Perf/Parallelism
		"iv_parallel_restore" "1" // EDITED BY BOOT

		// For perf reasons, since we don't use source-based DSP:
		"disable_source_soundscape_trace"       "1"
		
		// Networking - Induced latency (pred offset)
		"cl_tickpacket_recvmargin_desired" "5" 					// 5 ms base, min. floor for protecting against thrashing the queue
		"cl_tickpacket_desired_queuelength" "0"					// 0 = attempt to always reach the queue's min floor
		"cl_async_usercmd_send_disabled_recvmargin_min" "0.5"	// Additional frame since we do not use the async usercmd send (potentially unneccessary)
		"cl_clock_buffer_ticks"	"1"
		"cl_interp_ratio" "0"
		"cl_async_usercmd_send" "true"

		"fps_max"		"0"
		"fps_max_ui"	"120"

		"in_button_double_press_window" "0.3"

		// Convars that control spatialization of UI audio.
		"snd_ui_positional"								"1"
		"snd_ui_spatialization_spread"					"2.4"
		
		// sound volume rate change limiting
		"snd_envelope_rate"								"100.0"
		"snd_soundmixer_update_maximum_frame_rate" 		"0"

		//don't let people mess with speaker config settings.
		"speaker_config"
		{
			"min"		"0"
			"default"	"0"
			"max"		"2"
		}

		"cq_buffer_bloat_msecs_max" "120"

		"snd_soundmixer"						"Default_Mix"
		"cloth_filter_transform_stateless" "0"

		"cl_joystick_enabled" "0"
		"panorama_joystick_enabled" "0"

		"snd_event_browser_focus_events" "true"

		"cl_max_particle_pvs_aabb_edge_length" "100"
		
		// Allow aggregation of particles (for perf)
		"cl_aggregate_particles" "true"
		
		"citadel_enable_vdata_sound_preload" "true"

		"r_particle_allowprerender" "false"
	}

	Memory
	{
		"EstimatedMaxCPUMemUsageMB"	"1"
		"EstimatedMinGPUMemUsageMB"	"1"

		"ShowInsufficientPageFileMessageBox" "1"
		"ShowLowAvailableVirtualMemoryMessageBox" "1"
	}
}
