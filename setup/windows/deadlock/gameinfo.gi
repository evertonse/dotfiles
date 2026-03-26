
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
	
	// DisallowGameInfoConditionals 0 // was 11
	PGIVersion "BE1202D563B3FD8CC662113947A5F19C5239983ECFEA6AB94C3621F777E96F65"
	
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
			Game_Language		citadel_*LANGUAGE*
			Game_LowViolence	citadel_lv
                           
                        Mod         citadel
                        Mod                 core
                           
                        Game        citadel/addons
			Game	    citadel
			Game	    core
			
			Write               citadel
			Write               core
			
			AddonRoot           citadel_addons
			OfficialAddonRoot   citadel_community_addons
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

			// dev ToolsVis // Visualization modes for all shaders (lighting only, normal maps only, etc.)
			// dev ToolsWireframe // This should use the ToolsVis mode above instead of being its own mode\

			// tools ToolsUtil // Meant to be used to render tools sceneobjects that are mod-independent, like the origin grid
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
			FakeLag			40
			FakeLoss		.1
			//FakeReorderPct 0.05
			//FakeReorderDelay 10
			//FakeJitter "low"
			// Turning off fake jitter for now while I work on making the CQ totally solid
			FakeReorderPct 0
			FakeReorderDelay 0
			FakeJitter "off"
		}

		"SkipRedundantChangeCallbacks"	"1"
	}

	RenderSystem
	{
		// Larger index buffer pool = fewer mid-frame reallocations.
// Reallocations on DX11 stall the render thread while it waits
// for a new buffer to be mapped — during which prediction can
// get full bus access:
		IndexBufferPoolSizeMB  256 // was 32 
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
			"bakedlighting"	"1"	// Enable lightmapping during compile time		
			"envmap"	"0" // turned off since it currently causes an assert and doesn't work due to some build issue
			"nav"		"1"	// Generate nav mesh data
		}

		MeshCompiler
		{
			OptimizeForMeshlets 1
			TrianglesPerMeshlet 126	// Maximum valid value currently is 126
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
			UseStaticLightProbes 1 // was 9
			LPVAtlas 1
			BC6HHueShiftFixup 1 // was 0 Causes more artifacts than it solves atm
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
		GrassCastsShadows				1
	}

	SceneSystem
	{
		GpuLightBinner 1
		FogCachedShadowAtlasWidth 2048
		FogCachedShadowAtlasHeight 2048
		FogCachedShadowTileSize 128
		GpuLightBinnerSunLightFastPath 1
		CSMCascadeResolution 2048
		SunLightManagerCount 0
		SunLightManagerCountTools 0
		DefaultShadowTextureWidth 6144
		DefaultShadowTextureHeight 6144
		DynamicShadowResolution 1

		TransformTextureRowCount	512 // was 1024
		TransformTextureRowCountToolsMode 6144
		SunLightMaxCascadeSize		4
		SunLightShadowRenderMode	Depth
		LayerBatchThresholdFullsort 20
		NonTexturedGradientFog		1
		// Temp till I can add support in citadel shaders
		DisableLateAllocatedTransformBuffer 1
		MinimumLateAllocatedVertexCacheBufferSizeMB 32 //was 64
		CubemapFog 1
		VolumetricFog 1
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
		"DisableServerInterpCompensation"	"1"
		"DisableAnimationScript" 	"1"
		"ServerPoseRecipeHistorySize"	"120" // was 60
		"ClientPoseRecipeHistorySize"	"120" // was 60

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
	}

	ConVars
	{	 
		//=====================================================================================
		// README:
		// 	https://docs.comfig.app/latest/tf2/misconceptions/#bad-cvars
		//      This config tries to optimize memory contention from cpu because I only have 1 stick of ram DDR4 32gb 32mhz
		//      The CPU is Ryzen 5 4600g and GPU is 1660 GTX. So we try to sacrifice GPU to help the low end CPU and RAM usage
		//      the GPU is usually not the bottleneck as long as we're using under 6G VRAM
		//=====================================================================================
		// +exec autoexec.cfg -dev -convars_visible_by_default -dx11 -no_environment_maps -novid -noassert -nojoy  -high +@panorama_min_comp_layer_cache_cost_TURNED_OFF 256 
		// +exec autoexec.cfg -dx11 -novid -noassert -nojoy  +@panorama_min_comp_layer_cache_cost_TURNED_OFF 256
		// CS 1.6 https://gist.github.com/LeBaux/27223336ed5a44529208e8e17c63e0c1
		// -dev -convars_visible_by_default -novid -noassert -nojoy 
		// [QOL-2-2-3]:Aig0SxQjZMhMDi8lk6khZCADh4clKBQCQEEGkIyiAGVkZIxYQjZiCZlkAKBQwBgigwyAjCAcWFoyAicDycHjwRJLsMQShweZMwAAAIAMMmTQyJDJUPKBASXDkkwe
		//
		//=====================================================================================
		
		//>>> ================ INPUT ================ 
		m_rawinput  1
		m_filter 0                            // Disables mouse smoothing, improves responsiveness
		cl_input_enable_raw_keyboard 1
		cl_showerror 3
		//<<< ================ INPUT ================ 
				
		//<<< ================ PARTICLES ================ 
		
		r_particle_debug_filter "0"	
		

		r_citadel_screenspace_particles_full_res "0"
		r_particle_cables_culling "1"
		
		// cl_particle_simulate true // Works but cheat protected and simply no particles appear
		"r_drawparticles"	"1"	// FULL rendering disable (abilities become invisible)
		r_draw_instances "1" // (some particles does not get draw if 0)
		mat_reduceparticles 1
		r_draw_particle_children_with_parents 0 // @changed didint see any impact  	Draw particle children with parents (-1=use gameinfo, 0=no, 1=yes) 
		
		// These are definately the best batch mode 2 is very big for performance both in cpu and gpu 
		r_threaded_particles 1 // 1 is the DEFINATLY fast maybe @thread
		r_particle_model_per_thread_count 16	// devonly 	Default: 32 // @thread
		r_particle_parallel_simulation 1             // Lets particle simulation run on multiple CPU threads for better 1% lows in heavy fights
		r_particle_batch_simulate 1                   // Batches particle simulation work for smoother frametimes and less CPU overhead
		
		r_particle_allowprerender 1 // false = default
		cl_particle_simulate_parallel 1
		cl_aggregate_particles   1 // true should be faster  @batch
		cl_particle_batch_mode 2 //  1 is deafult 2 Uses aggressive batch processing (verify). Tries not to display a large number of particles  // @batch
		particle_cluster_nodraw 1 // Skips drawing particle “clusters”/grouped particle batches (performance, fewer small effects). [def: "0"]
	
	
		// r_particle_force_material_binds 0 // Def: 0
		r_particle_max_draw_distance 32000 // @range Lower = less particle range, more FPS, dont go below this value (300000) it doesnt draw trooper hp bar,

		
		"r_particle_batch_collections" "1" // @batch
		
		// use the new particle system for creating new particles
		cl_new_impact_effects 0
		
		cl_particle_fallback_base 6                                // (4) (this changes sinners light) Base for falling back to cheaper effects under load. [def: "0"]
		cl_particle_fallback_multiplier 6                             // (4) Multiplier for falling back to cheaper effects under load. [def: "0"]
		
		cl_particle_sim_fallback_threshold_ms 4                     // If particle sim cost exceeds this (ms), the engine can fall back to cheaper particle simulation to avoid spikes. [def: "6"]
		cl_particle_sim_fallback_base_multiplier 20                  // How aggressive the switch to fallbacks will be depending on how far over the cl_particle_sim_fallback_threshold_ms the sim time is. (Higher = more aggressive). [def: "5"]

		// r_particle_skip_postsim 1
		// r_particle_skip_update 1	// IMPORTANT: 0, otherwise desync and animation lag (1 it skips)

		// From here below the particles section changes Celeste spikes on the circle ability. It disappears, making it harder to dodge it.
		"r_particle_low_res_render"	1
		
		r_particle_max_texture_layers 3 //was -1
		
		r_particle_cables_cast_shadows 0      // Disables cable shadows, saves GPU
		r_citadel_screenspace_particles_full_res 0
		
		
		r_particle_depth_feathering 0 // maybe better? was 0
			
		// "cl_particle_max_count" 	"1100"	// @change Particle limit in world - 0. 0 Means how much it needs ( avoids console spamming) // If console is flooded with max particles exceeded warnings. [def: "0"]			
		cl_particle_budget 0	// 0 = dynamic budge
		
		// particle_sim_alt_cores 4 // was 2 It was in the config before because I didn't read the code for how the command is used before I removed it. It is only used for Xbox 360 and even if it was allowed on PC, it forces the value to be no greater than 2.
		// r_particle_update_rate 2	// 0 = update every tick (stable)				
		


		// don't create particle systems when things hit surfaces, perf and distracting
		r_drawflecks 0 // Do not create particle systems when things hit surfaces. Increases FPS and reduces distractions. if 1 = Use the "flecks" variant for impact FX
		// don't draw impact debris effects
		fx_drawimpactdebris 0
		// don't draw impact dust effects
		fx_drawimpactdust 0
		// don't draw metal spark effects
		fx_drawmetalspark 0

		r_particle_cables_render 0
		r_citadel_half_res_noisy_effects 1	
		
		r_particle_radius_cull 1	// Remove ALL particles with radius < 9999 (i.e. almost all)
		r_particle_max_size_cull 400 // was 800 Particle systems larger than this in every dimension skip culling to save CPU.  They will be drawn anyway def: 1200
		r_particle_sim_spike_threshold_ms 10 // Raised threshold to avoid warning spam
		r_particle_shadows 0	// Particle shadows - OFF
		
		
	
		
	
		// "r_particle_mixed_resolution_viewstart" "1" // 800
		r_particle_max_detail_level  0 // was 0 but setts ball strangeThe maximum detail level of particle to create. [def: "3"]
		
	
		
	
		
		r_physics_particle_op_spawn_scale "0"                           // Prevents physics-based particle spawns. [def: "1"]
		r_RainParticleDensity "0"                                       // Density of Particle Rain 0-1. [def: "1"]
		r_world_wind_strength "0"                                       // Disables wind effects, cosmetic only. [def: "40"]
		r_particle_shadows_compute 0
		"r_particle_lighting_enable"	"0"	// Particle lighting - OFF
	

		
		cl_max_particle_pvs_aabb_edge_length "100" // 100  default 1024 @changed
	
		//// https://www.funplay.pro/en/convars
		r_particle_newinput 	1 // devonly 	Default: false Enable input path in particle ops
	 	// r_particle_render_refreshes_sleep_timer 	false //  devonly 	Default: true Disable to get a better look at what's happening offscreen
	
		cl_particle_retire_cost 0 // was"0.00025"                                   // was 0.1 Particles retired earlier under CPU load â†’ prevents teamfight frame spikes.
		
		// r_particle_model_old 	1 // devonly 	Default: false
		cl_smoke_player_particle_effect 0
		// r_particle_enable_fastpath 0 // Def: 1
		r_particle_gpu_implicit  1 // Def: 1
		r_particle_gpu_implicit_lds_cache 1 // Def: 0 //new
		
	
		// r_particle_min_timestep 0.0075 // "0.001"
		r_update_particles_on_render_only_frames true // default false
		r_limit_particle_job_duration true // Def: false // @new
		r_late_particle_job_sync true // Def: false 
		


		// https://gist.github.com/ouwou/d6d1c6abe769b654270b1725e7121e9a
		// game_particle_manager_requeue_messages false // Def: true @thread Effects never get cleared on certain hero (green char, drifter) if this is set to true.
		// particle_snapshot_allow_combined_models true // Def: false
		// r_citadel_allow_particle_only_portraits false // Def: true
		// r_citadel_highlight_particle_only_portraits  false // Def: false
		

		
		
		
		
		
		// cl_particleeffect_aabb_buffer 2
		
		r_citadel_prewarm_particles true

		//<<< ================ PARTICLES ====================
		
		//>>> ================ LOD & CULLING ================
		cl_detailfade				"0"	// def. "400"		# Distance across which detail props fade in
		cl_detaildist				1	// def. "1200" was 800		# Distance at which detail props are no longer visible
		cl_drawmonitors 0
		"r_drawskybox"	"0"
		
		// r_lod 0 // This forces everything to LOD 1, when the lowest quality is LOD 7. 
		r_rootlod 7 // Whereas this handles base quality while still allowing for lower qualities to be used at a distance.
		r_staticprop_lod 6 // Force highest LOD (high quality with no fading)
		// r_lod_force_level 6
		// sc_force_lod_level 2
		// "r_lod_force_level" "2" 
		
		"r_shadowlod"	"0"
		
		"sc_screen_size_lod_scale_override" "0.01" //was -1 and 0.01 @change
	

		"sc_instanced_mesh_lod_bias" "10"     // [FPS IMPACT] Higher = lower quality models, more FPS | 0=High quality | 10=Low quality
		"sc_instanced_mesh_lod_bias_shadow" "10" // Bias for LOD selection of instanced meshes in shadowmaps
		"sc_instanced_mesh_motion_vectors" "0" // Set 1 if you use motion blur
		"sc_instanced_mesh_size_cull_bias" "10" // Bias for size culling of instanced meshes
		"sc_instanced_mesh_size_cull_bias_shadow" "100" // Bias for size culling instanced meshes in shadowmaps
	
		
		// BVH threshold — below this, the bounding volume hierarchy isn't used,
		// falling back to a linear scan. On single -channel a linear scan is
		// actually cheaper than pointer-chasing through a BVH tree:
		"sc_clutter_enable" "0"                   // [FPS IMPACT] 0=No debris/props (max FPS) | 1=Props visible (immersive)
		"sc_aggregate_bvh_threshold"  256       //was 16  Lower BVH threshold (default: 128)
		"sc_layer_batch_threshold" 256     //was 16  Lower batch threshold (default: 128)
		"sc_layer_batch_threshold_fullsort"  160 //was 20 default 80
		
	
		"sc_fade_distance_scale_override" 0.8 // was 180 @range (minions health bar dispear is this is too high (lower = more normal))
		"sv_pvs_max_distance" "2400" //was 2800 default 4000, @range unrender things(boxes, creeps, objs,etc) behind walls or out of viewing distance, does not affect player model.
		
		
		r_entity_cull_distance_multiplier "1.25"                        // Scales down draw distances for entities disappear sooner, fewer draw calls. (health bars dissapear as well)
		"r_size_cull_threshold"	"1.23"  // higher is less cpu usage (20 is unsable) 
		"r_size_cull_threshold_shadow"	75
		"citadel_use_pvs_for_players" 0 //default false, culls players when out of view ( I think this makes the hp bar disapear when players area occluded TEST)
		"sv_remove_ent_from_pvs" "1" //default 0 remove entities from potential view something, basically culling objs outside of view
	
		r_cullforperformance 1
		
		r_gpu_cull "1"
		r_gpu_cull_models "1"
		r_gpu_cull_models_range	"4600" // @range
		
		"r_occlusion"	1 // @changed was 1 Use CPU to have the GPU skip rendering models/props you cannot see
		"r_occlusion_culling"	 1 
		r_occludeemaxarea   1 // Prevents occlusion testing for entities that take up more than X% of the screen. 0 means use whatever the level said to use."
		r_occluderminarea     1 // Prevents this occluder from being used if it takes up less than X% of the screen. 0 means use whatever the level said to use."
		r_occludermincount   1 // Def: 1 ( // Use the largest occluder at least) to force ocluder At least this many occluders will be used, no matter how big they are."
		// r_occlusionspew 0

		
		"r_citadel_gpu_culling_shadows"	"1"
		"r_cull_duplicate_shadows"	"1"
		"r_cull_shadowcasters_using_bounds"	"1"
		"show_visibility_boxes"	"0"	// Visibility boxes
		
		
		r_propsmaxdist 0 // was 400 Maximum distance from where client-side physics props are visible
		cl_maxrenderable_dist 4800


		"r_farz" "5100" //@range was 6000 default -1 far clipping plane, same as r_mapextents but this affect another thing that i dont understand yet, it gives fps though
		// r_nearz 18 // this works but doesnt help in anything i think
		"r_mapextents" "2500" //was "4500" Default: 16384<br>Set the max dimension for the map.  This determines the far clipping plane, set to higher number if no like popping building @range
		
		// phys_cull_internal_mesh_contacts  true //default false

		
		// r_citadel_depth_prepass_cull_threshold 60 // was 60
		r_force_zprepass -1 // Def: -1. 0: @changed Force z prepass off. 1: Force on. -1: Don't force Early Z pass. 
		r_fastzreject 0 // Value 0 def. Disable for slow CPU and fast GPU @changed Uses the CPU to prevent overdraw.
		r_citadel_gpu_culling_two_pass 0 // was 1 maybe in 1 particles gets ocluded more often @changed
		r_citadel_depth_prepass_dynamic_objects 0 //was 0  maybe better use 1 to allow prepass to cull particles which are dynamic

		
		lod_TransitionDist -1 // Do not fade in map objects for maximum performance
		//lod_TransitionDist -5001 // Fade map objects across a shorter distance to slightly reduce pop in while still increasing performance
		//lod_TransitionDist -5000 // Fade map objects over a long distance to reduce pop in and clutter while still increasing performance		
		//lod_TransitionDist 3592 // Start fading map objects only when they are very far away, decreases performance but has the least pop in

		//<<< ================ LOD & CULLING ================
		
		//>>> ================ NETWORK ================
		// https://deadlock.wiki/Console_commands
		
		net_skip_redundant_change_callbacks true // default false im p sure this keep pulling up report screen for some reason
		
		// cl_lagcompensation 1
		

		//  https://developer.valvesoftware.com/wiki/NS_Variables#cl_cmdbackup
		// cl_cmdbackup 16 // https://steamcommunity.com/sharedfiles/filedetails/?id=1116463337 Maybe invalid for source 2
	
		cl_parallel_readpacketentities 1 // Def: 1 @thread when 0 we get packentities  0.22ms avarage Prediction 0.75
		cl_parallel_readpacketentities_threshold 20
		
		
		// "cl_resend"	"15"  // amount of time the game client will wait before resending a connection attempt, should the previous one have failed.			
		// "cl_resendinterval"	"2"
		
		
		// The default value is 1.
		// Values:
		// 0 - Send packets and split packets immediately
		// 1 - Send packets and the first split packet in a sequence immediately, but queue the rest of the split packets on a separate thread and send them after a delay in between each split packet
		// 581304 - Queue all packets on a separate thread and send them after a delay in between each packet
		// I tested 0 on Windows and didn't encounter these issues, but if other people experience it, then I'll set it to the default of 1. By the way, what CPU are you using?
                 // Also, stabby, are you using the -NoQueuedPacketThread launch option with net_queued_packet_thread 1?
		// EDIT: After looking at the documentation about how the Windows network system works, and then crying, I've decided that net_queued_packet_thread 1 is unfortunately necessary for Windows, except in some rare cases.
		
		// you can change this to 581304 to always thread packets
		// very demanding of your computer, and the network system
		// keep it at 1 if your computer can't handle it
		// net_queued_packet_thread 0  // @thread
		net_queued_packet_thread 581304 // @change Use a high priority thread to send queued packets out instead of sending them each frame.
				
		
		// if you have a fast enough network, 0 is recommended.	
		// net_maxroutable 1260;net_maxfragments 1260 // Use max recommended packet size by Steam to avoid split packets more to save CPU time and packet overhead
		net_compresspackets 1; net_compresspackets_minsize 200 // Compress a few serverbound packets for maximum data saving

	
		

	
		// "net_async_clientconnect" "1" @thread
		// "engine_max_ticks_to_simulate" "16" // 33
		
	
					
		cl_maxpackets 512 // 128
		
		// cl_clock_correction true          // 	was "true" // (test)	Stops artificial smoothing that adds subtle delay
		// cl_net_buffer_ticks 1
		// "cl_net_buffer_ticks_use_interp"    1


		// packet level ping control
		// net_maxcleartime 0.015 // was 0.5
		// net_maxpacketdrop 100 // was 100 or 0  some people allow this 4000
		
		// allow for split packets at the higher 
		// how many packets we can split per frame
		// net_splitrate 30000 // was 1 people allow 4
		// net_splitpacket_maxrate 786432
		net_splitpacket_maxrate	"1000000" // was  "30000"
		
		// max out file upload size for extra content
		// net_maxfilesize 128
		
		// net_maxcleartime	"0 .004" // was "0.005"
	
		// net_maxfilesize 64 
		
		// r_experimental_lag_limiter 1 // was @new

		// adjust delay between interpolating entities, set to 0 to use interp ratio
		
		// ------ There are related ---------- ///		
		// cl_cmdrate 32 // Def: 32 was 64 works well 
		// cl_updaterate 32 // Def: 32 was 128 actually tanother site says 20 is default.
		// cl_usercmd_max_per_movemsg 8 	// was 8 Def: 4. max number of CUserCmds to send in one client move message 
		
		// cl_interp 0.0303 // from https://docs.comfig.app/latest/tf2/misconceptions/#resolution-and-windows-launch-options
		// cl_interp 0
		// cl_interp_hermite 0 // Def: 1 Set to zero do disable hermite interpolation. (Server probably is hermite, can this affect prediction? better to leave at default)
		cl_interp_ratio 0 // Def: 0. Try 2 for a reason that I don't remember. Better leave at default. Multiplier that affects interpolation time (often cl_interp_ratio / cl_updaterate). 
		
		// cl_interp_npcs 5.5 // Interpolate NPC positions starting this many seconds in past (or cl_interp, if greater)
		// cl_interp_simulationvars 1 // Interpolate LATCH_SIMULATION_BIT vars if interpolation interval is greater than animation interval
		// cl_interp_threadmodeticks 1 // Def: 0 // Additional interpolation ticks to use when interpolating with threaded engine mode set.
		cl_interp_parallel 1

		
		net_culloptimization 	1 // devonly 	Default: true Enable optimization of slow path that makes HLTV CPU consumption high in AnimGraph-using mods. Will switch to this on by default soon.
		
		"sv_networkvar_validate" "false"		// Validate each StateChanged against known offsets.
		"sv_networkvar_perfieldtracking" "false"	// Track individual field offset changes, rather than a single dirty flag for the whole entity.
		//<<< ================  NETWORK ===============
		//>>> ================ PREDICTION =================
		cl_showerror  	3 // Show prediction errors, 2 for above plus detailed field deltas, 3 to filter out serverside known prediction errors, -entindex for specific entity. 
		
		cl_smooth 1                     // [ADJUST] 0=No smoothing (lower input lag) | 1=Smoothing enabled (may add delay)
		cl_smooth_draw_debug "0"
		// cl_smoothtime	"0.012" 
		// cl_smooth_root_timehorizon 0.05   // default 0.125, reduces smoothing window
		// cl_smooth_root_catchup_factor 0.5  // default 0.21, faster catchup
		
		cl_predict	1
		// cl_predictweapons	 0 //  1 default
		// cl_predictphysics 0
		cl_pred_optimize 2	 // was 2 but 1 seems to work better even if it's supposed to avoid copies
		// cl_pred_always_latch 1 // Def: 0
		// cl_pred_max_error_ticks 4 // maybe this can't be set, saw on console once
		perf_fire_bullet_firstpredictedonly  1 	
		
		cl_prediction_savedata_postentitypacketreceived 1 // Valves ask us to delete this from deadlock cvarlist
		cl_predict_after_every_createmove 0 // test 1 0
		cl_predictioncopy_runs 0 // put to 1 if character vibrates (jitter, jumpy) Default: true
		cl_pred_parallel_postnetwork 1 // Def: 1/0 ? https://gist.github.com/ouwou/d6d1c6abe769b654270b1725e7121e9a
		
		engine_low_latency_sleep_after_client_tick 0  // was 1. Prevents extra engine sleep between frames for more consistent frametimes at the cost of slightly higher CPU usage
		// engine_low_latency_sleep_after_client_tick "1"                  // Sleeps strategically after client tick to reduce latency/stutter (low-latency pacing).                                                                       // Def. = "1"
		engine_low_latency_sleep_after_render_tick 0                  // Sleeps strategically after rendering to reduce latency/stutter (frame pacing).     

		// engine_no_focus_sleep 				     "1"			// Milliseconds the engine sleeps per frame when unfocused (0 = no sleep, not recommended for low-end PC). [def: "20"]
		// cl_pred_doresetlatch 1 
				
		// Perf/Parallelism @thread
		iv_parallel_restore 1 // Def: 1
		// iv_parallel_latch     1 // Def: 0
		// iv_wrapped_parallel_latch  0 // devonly, cl 	Default: true
		// save_parallel         1 // Def: false ?
		// threadpool_thread_limit 12                     // Allows the engine to use all available worker threads (helps most on 8+ core CPUs) @thread
		//<<< ================ PREDICTION ================
		
		//>>> ================ ANIMATION ================
		"animgraph_enable"	1
		"animgraph_record_all"	"0"	// AnimGraph data recording
		
		"anim_decode_forcewritealltransforms" "false" //Default: false<br>Force BatchAnimationDecode to write transformations for all bones
		"animgraph_draw_traces"	 0
		
		"animgraph_enable_parallel_op_evaluation"	1	// was 1 Def: 0 Parallel AnimGraph operations // @thread
		"animgraph_enable_parallel_update"	1	        // Def: true Parallel animation update // @thread
		"animgraph_enable_parallel_preupdate"  1               // was 1 @thread default false Enables parallel processing for the pre-update phase of animation graphs, helping spread the load across more CPU cores // 
		
		animgraph_enable_dirty_netvar_optimization 	true // devonly 	Default: true
		"citadel_movement_debugdraw"	"0"	// Movement debugging

		"citadel_player_anim_debug"	"0"	// Player animation debugging
		"citadel_player_debug_animgraph_movement"	"0"	// AnimGraph movement debugging



		// ik_enable 0 // @new
		// ik_final_fixup_enable "0"                                       // Disables final IK fixup pass (cheaper animations, potentially less accurate). [def: "1"]
		// ik_fabrik_align_chain "0"                                       // Disables FABRIK chain alignment in IK (cheaper). [def: "1"]
		
		// cl_skel_constraints_enable false		
		// skeleton_instance_lod_optimization "1"                          // Enables skeleton/animation LOD optimizations (less bone work for distant models). [def: "0"]
		// skel_constraints_enable 0 // Def:1
		
		// I'm commenting the footlock section because I suspect it bugs the camera on some melee punch such  as venator's
		// animgraph_footlock_enabled 0
		// animgraph_footlock_ik_enable 0
		// animgraph_footlock_calculate_tilt 	false // devonly, rep 	Default: true
		// animgraph_footlock_auto_stair_detection 	false // devonly, rep 	Default: true Attempt to detect when the foot is on a stair and will stop it from tilting to reach the next s
		// animgraph_footlock_auto_ledge_detection 	false // devonly, rep 	Default: true Attempt to detect when the foot is partially hanging off a ledge and stop it tilting to reach the botto
		// animgraph_slowdownonslopes_enabled false
		// animgraph_slope_enable 	false 	// sv, cl, rep, cheat 	
		// animgraph_trace_static_only 	true // false 	sv, cl, rep, cheat 	
		
	
		
		// anim_3wayblend 0 // disable 3-way animation blending if 0
		// enable_boneflex 0 // IMPORTANT Melee Venator and other bugs ways to hard with mispredicts if this is false
		r_flex 0
		flex_rules 0
		flex_smooth 0

		skeleton_instance_lod_optimization 1
		cl_jiggle_bone_framerate_cutoff 1 // Disab		le bone physics
		cl_threaded_bone_setup 1 // was 1 @thread
	        cl_threaded_bvs 1 // was 1 @thread
			

		cl_threaded_client_leaf_system 1 // was 1 @thread
		

		// duration of an eye blink (do not set to 0, or else TF2 will divide by 0)
		// blink_duration 0.0304
		r_eyemove 0 // If eyes move flag
		cl_SetupAllBones 0
		citadel_ag2_controller_parallel_update_enabled "1"              // Enables parallel updates for the Citadel/AG2 animation controller (performance).                                                                             // Def. = "1"
	
		// These two make the camera jumpy and nausiating when climbing / vaulting over ledges
		// "citadel_mantle_cancelling_allowed" "true" 
		// "citadel_mantle_horizontal_movement_distance" "64"
		
		//<<< ================ ANIMATION ================
		
		//>>> ================  PHYSICS  ================
		// Physics section certain keys can can bugs with the camera on something melee punch (tested on venator's) and movement abilities like silver's
		cl_phys_maxticks 5 // was 3
		cl_phys_enabled 1 // was 0 @changed
		phys_dynamic_scaling 1                                        // Physics auto-simplifies under heavy load â†’ stabilizes teamfight FPS.
		phys_log_updaters 0	// Physics update logs
		
		phys_multithreading_enabled	 1	// Multithreaded physics 1 is good @thread
		phys_step_threaded 1 // Def: 1 // @thread
		
		"phys_powered_ragdoll_debug"	"0"	// Powered ragdoll debugging
		"phys_show_stats"	"0"	// Physics stats
		"phys_visualize_traces"	"0"	// Physics trace visualization
		"ragdoll_lru_debug_removal"	"0"	// Body removal debugging
		"ragdoll_parallel_pose_control"	 1	// Parallel body poses // @thread
		
		"func_break_max_pieces" "0"
		
		"cl_phys_props_max" "0"
		"cl_phys_props_enable" "0"
		"citadel_breakable_prop_break_airtime" "0"
		"props_break_max_pieces_perframe"	"1"	// Boxes disappear instantly (no pieces)  if set to zero floods the console
		
		// I believe the camera problem when punching comes from here and disabling physics
		cl_fasttempentcollision "1000000"                                // Never check collision, let it just timeout instead. Limits/controls fast collision processing for temporary entities (impacts/tracers/etc.); higher usually = more work. [def: "5"] //test Temp Entities" are things like shell casings hitting the floor. Increasing this number usually tells the engine to skip collision checks for them entirely or expire them instantly to avoid physics costs.
		// "cl_phys_timescale" 0 // 1 normal @changed
		// cl_phys_sleep_enable  1
		
		"props_break_radial_force_ratio" "0"
		"props_break_apply_radial_forces" "false"

		phys_threaded_cloth_bone_update 1 // @thread
		phys_threaded_kinematic_bone_update 1 // @thread
		phys_threaded_transform_update 1 // @thread // def: 0

		//<<< ================  PHYSICS  ================
		
		//>>> ================== MODELS ================= 
		cl_disable_ragdolls "1"                                         // Keep set to true - disabling this (enabling ragdolls) can cause issue with doorman's ultimate. [def: "0"]
		cl_ragdoll_limit "0"
		g_debug_ragdoll_visualize	"0"	// Ragdoll visualization
		g_ragdoll_fadespeed                               "0" //was 999
		g_ragdoll_lvfadespeed                             "0"
		cl_ragdoll_collide			"0"	// def. "0"		# Collision between corpses on(1)/off(0)
		"g_ragdoll_important_maxcount"	"0"	// Important ragdoll limit
		"g_ragdoll_lifetime"	"0"	// Body lifetime

		
		skeleton_instance_lod_optimization "1"                          // Enables skeleton/animation LOD optimizations (less bone work for distant models). [def: "0"]
		
		// mp_usehwmmodels				"0"	// def. "0"		# Enable the use of the hw morph models. (-1 = never, 1 = always, 0 = based upon GPU)
		// mp_usehwmvcds				"0"	// def. "0"		# Enable the use of the hw morph vcd(s). (-1 = never, 1 = always, 0 = based upon GPU)


		sparseshadowtree_enable_rendering 1 // Disables advanced sparse shadow system, big performance saver
		sparseshadowtree_disable_for_viewmodel 0  // Prevents viewmodel from using sparse shadows
		//<<<  ================== MODELS ================= 
		
		//>>> ================ AI ================
		// ai_disabled 0 // if 1 minions don't move in sandbox mode
		ai_expression_optimization 1	// AI expression optimization
		citadel_npc_force_animate_every_tick 		"false"
		ai_expression_frametime 0
		ai_gather_conditions_async "true" // @new @thread
		ai_strong_optimizations_no_checkstand "1"
		think_limit  1                                               //was 2Limits how much “think” time/entities can process per tick (CPU cap). [def: "0"]
		
		
		// the maximum frametime before AI is made more efficient
		// it isn't exactly TF2 related, but it can help with Source games/mods
		// with AI, and the default value is 50, so the more efficient AI
		// has probably never seen use (it would activate if one frame took 50 secs to render)
		// in this config, it is set to 1/66 (which is our ideal frametime)
		// ai_frametime_limit 0.0052
		"cl_simulate_dormant_entities" "false"
		//<<< ================ AI ================
		
		
		//>>> ================ TEXTURE STREAMING and MEMORY ================	
		// This section does remove all importante ability textures that inform important cues.
		// Also invalidade some textures on character models making it appear black spots on paradox and green char
		
		// if you have black textures, disable mipmapping textures
		mat_mipmaptextures 1
		r_mipgen_compute_shader "1" // @new
		r_citadel_fsr_enable_mip_bias "1" // @new
		
		r_cache_pool_allocations 1 // @ If 0 maybe less memory usage is good?
		// r_allow_low_gpu_memory_mode 0 // was 1
		r_allow_onesweep_gpusort 1 // was 1
		// r_use_memory_budget_model true // was true
		r_dynamic 0    // Disables dynamic lighting updates (reduces lighting cost, flatter visuals).                                                                                  // Def. = "0"

		// r_buffer_size "131072"
				
		// MEMORY CLEAN
		// r_pipeline_stats_present_flush "1"
		// r_pipeline_stats_command_flush "1"
		// don't do memory flushes
		// host_flush_threshold 0
		
		// size of the data cache, used for some values
		// datacachesize 512
		// keepthe LZMA compression system in memory so it doesn't have to be started every time
		lzma_persistent_buffer 1
		// minimum memory used by heap
		// mem_min_heapsize 	1024
		// maximum memory used by heap
		// mem_max_heapsize 16384
		// maximum memory used by heap if you have 256MB to 512MB memory
		// mem_max_heapsize_dedicated 16384
		// TEST: clean up unused textures on death
		cl_clean_textures_on_death 1
		
		"mat_picmip"  4
				
		"r_texture_stream_mip_bias" 4     // [FPS IMPACT] Higher = blurrier textures, more FPS | 0=High quality | 2=Balanced | 4=Low quality
		
		"r_texture_lod_scale" "4"               // [FPS IMPACT] 0=High quality (sharp) | 2=Medium | 4=Low quality (blurry, max FPS)
		
		"r_texture_pool_size" "1024"         // [ADJUST] VRAM usage in MB - Lower = less VRAM used, may cause texture pop-in | 512-1024 range
		
		"r_fallback_texture_lod_scale" 4 // Def: 2
		
		"r_texture_budget_update_period" "1.5" // Faster texture streaming adjustment 0.05
		"r_texture_pool_reduce_rate" "128" // was 64
		
		// "r_texture_budget_dynamic" "1"          //was 1 Dynamic texture budget adjustment
		"r_texture_budget_threshold" "0.8"
		
		"r_texture_anisotropic"	"4"	// Left at 0
		"r_texture_filter_textures"	"0"
		
		"r_texture_streaming"	"1"
		// "r_texture_stream_use_only_streamable"	1 // was 1, if 1 shits get crazy bad
		"r_texture_stream_lowres_drop_rate"	"6"
		"r_texture_stream_mip_skip"	"1"
		"r_texture_stream_pool_budget"	"1024" // was 1024
		"r_texture_stream_resolution_bias" "0.2"
		r_renderoverlayfragment			0	// def. "1"		# Rendering of multiple Texturelayers on(1)/off(0)
		"r_texturefilteringquality"	"0"
		mat_use_compressed_hdr_textures 1
		
		//<<< ================ TEXTURE STREAMING and MEMORY ================
		
		//>>>  ================ ROPES ================
		cl_glow_brightness 0 // Def: 1 		 
		
		r_queued_ropes 0                                             // was 1if 1Rope rendering queued to worker thread frees main @thread. 
		r_ropetranslucent			"0"	// def. "1"		# Transparent ropes on(1)/off(0)
		rope_averagelight			"0"	// def. "1"		# Makes ropes use average of cubemap lighting instead of max intensity. on(1)/off(0)
		rope_collide				"0"	// def. "1"		# Collide rope with the world on(1)/off(0)
		rope_rendersolid			"0"	// def. "1"		# Render Ropes on(1)/off(0)

		// skip drawing non solid part of ropes
		rope_solid_minalpha 0
		rope_solid_minwidth 0

		r_rope_holiday_light_scale 0
		r_ropes_holiday_lights_allowed 0
		

		rope_shake				"0"	// def. "0"		# Ropes shake around on(1)/off(0)
		rope_smooth				"0"	// def. "1"		# Do an antialiasing effect on ropes on(1)/off(0)
		rope_smooth_enlarge			"0"	// def. "1"		# How much to enlarge ropes in screen space for antialiasing effect
		rope_smooth_maxalpha			"0"	// def. "0"		# Max Alpha for rope antialiasing effect
		rope_smooth_minalpha			"0"	// def. "0"		# Min Alpha for rope antialiasing effect
		rope_smooth_minwidth			"0"	// def. "0"		# When using smoothing, this is the min screenspace width it lets a rope shrink to
		rope_subdiv				"0"	// def. "2"		# Rope subdivision amount Anti-Aliasing on(2,4,8)/off(0)
		rope_wind_dist				"0"	// def. "1000"		# Don't use CPU applying small wind gusts to ropes when they're past this distance

		r_drawropes "0"
		rope_subdiv "0"
		rope_wind_dist "0"
		rope_smooth_enlarge "0"
		rope_smooth_maxalpha "0"
		rope_smooth_maxalphawidth "0"
		rope_smooth_minalpha "0"
		rope_smooth_minwidth "0"

		//<<<  ================ ROPES ================



		//>>> ==================  RENDERING ==================
		r_threaded_renderables 1  // @thread they say it's not used
		r_threaded_shadow_clip 1 // @thread

		// mat_queue_mode -1 = auto, on DX11 it often picks threaded.
		// Threaded = render thread and game thread both reading RAM simultaneously.
		// Mode 0 serializes them - one bus consumer at a time:
		mat_queue_mode -1 // @changed was 0 @thread new // 2 best
		// mat_cb_per_batch 1
		// mat_viewportscale "0.7" // Was 1 this controls LOD on everything except trees and bushes (good) for some reason
		
		r_render_view_scale "0.005" // idk
		
		"r_drawtranslucentrenderables" 0
		r_drawtranslucentworld 0
		r_opaque  "1" // was 1
		r_translucent "1" // was 1
		// r_zprepass_normals 	false // false 	cheat  	0: Use normals reconstruc	ted from depth. 1: Output correct normals in z prepass. 
		
		
		r_frame_sync_enable 0                                         // CPU-GPU frame sync disabled â†’ lower latency, CPU doesn't wait for GPU.
		
				
		r_render_portals "1"
		r_max_portal_render_targets 	2
		
		r_dopixelvisibility 1                                    // (if false we get hardware does not support this on a gtx 1660) Disables pixel visibility queries for glow/halo effects â†’ GPU query overhead removed. Do not do CPU intensive pixelvis
		r_drawpixelvisibility 0
		r_pixelvisibility_partial 0 // was 1																									
		r_pixelvisibility_spew "0"
		
		// r_extra_render_frames 1 // Def: 0  Lags a lot with it on
		
		// cl_drawhud 0 // Def: 1
		// r_drawpanorama 1 // Def: 1
			
		// Decals
		r_drawdecals 1 // This is IMPORTANT because certain  skills needs decals to be visible
		"r_character_decal_monitor_render_res" "64" //Default: 512<br>
		"r_decals" 1                 // im p sure valve killed this command [ADJUST] Max decals visible: 1= only 1 bullet hole(max FPS) | 16=default
		r_queued_decals 1 // if 1 Queued decals fire a worker thread during scene rendering. @thread (was 1)
		r_decalstaticprops 1 
		mp_decals 1
		r_decal_cover_count 2 // was 4 // Remove decal when there is 2 decal in its place/close to completely covering it
		r_decal_overlap_area .001 // Remove decal when there is another decal covering it
		r_decal_overlap_count 1 // Do not allow decals to overlap each other
		r_drawbatchdecals 1  // Was 1  Render decals batched.

		// r_decals  100 //: 2048 @new
		
				citadel_breakable_prop_breakable_enabled "1" // @new
		r_drawdetailprops 0
		r_drawmodeldecals 0
		r_maxmodeldecal				1	// def. "32"		# Count of Decals to Render on the Models
		r_character_decal_resolution "1" // def 1
		// r_reset_character_decals 1 // was 1 
		r_decals_max_on_deformables 0 // @new
		r_character_decal_monitor_draw_frustum "0" // @new
		r_character_decal_monitor_emissive "0" // @new
		r_character_decal_monitor_render_res 1 // @new

		r_maxnewsamples                                   "0"
		r_maxsampledist                                   "0"
		r_minnewsamples                                   "0"
		
		// clips entity rendering according to a plane determined at each entity run
		// improves render performance at the cost of CPU
		// should pretty much always be kept on, unless you have a really weak CPU
		r_entityclips 1
		
		// draw characters' eyes, is a performance hit
		r_eyes 0
		// offload eye glinting to the CPU, using the same method as in DX8
		// if you have a slow GPU, enable this
		r_glint_procedural 0

		// render teeth, small performance boost if disabled
		r_teeth 0
		

		sc_aggregate_indirect_draw_compaction 	true 	// @change release 	Use multidrawindirect...count if the driver/hardware supports it
		sc_aggregate_indirect_draw_compaction_threshold 	100	// was 16 Def: 8 release 	Higher = fewer passes Threshold of indirect draws when we will do compaction 
	
	
		// sc_disable_culling_boxes 	false 	cheat 	
		// sc_disable_procedural_layer_rendering 	false 	cheat
		// sc_disable_shadow_fastpath 	false 	cheat 	
		// sc_disable_shadow_materials 	false 	cheat 	
		// sc_disable_spotlight_shadows 	false 	cheat 	
		// sc_disable_world_materials 	true // false 	cheat 	
		// sc_disableThreading  true // false  @thread
		
		// anim_resource_validate_on_load 	false // true 	release 	Validates the animation group channel list against the animations on load for every animation
		// animated_material_attributes 	false // true 	cl, cheat 

		// r_skinning_enabled 1


	
		//mat_max_worldmesh_vertices 65536 // Use maximum mesh vertices to reduce mesh count and improve performance
		// mat_max_worldmesh_vertices 1024 // Reduce individual mesh complexity for compatibility
		// mat_forcemanagedtextureintohardware 0 // [0,1] - If set to 1, attempts to force texture information into your Video RAM at the start of a level, alleviating any stuttering in the game. Also note that in my experience this setting can reduce FPS by up to 50%. Setting this variable to 0 may improve performance on some machines.
		// mat_forcehardwaresync 1 // https://steamcommunity.com/sharedfiles/filedetails/?id=2864788404 // Keep the CPU submission within 1 to 2 frames of the GPU
		// mat_levelflush 0
		
		
		
		r_drawfoliage 0
		
		"r_debug_precipitation"	"0"	// Precipitation debugging
		"r_draw_batches"	0
		"r_drawdevvisualizers"	"0"	// Dev visualizers

		"r_drawtracers" 0 // was 1 This is to see the bullet trace
		"r_drawtracers_firstperson"	0 // was 1 
		tracer_extra 0 // 1 = Make bullet lines more visible, low performance impact 0 = Remove extra fluff to bullet lines that make them thicker
		
		"citadel_bullet_log_entities_hit"	"0"	// Bullet hit logging @new
		"citadel_bullet_tracer_recycling_enabled"	"1"	// Tracer recycling @new

"fx_drawmetalspark" "false" //Default: true<br>Draw metal spark effects.
		
		// renders textures dynamically
		disp_dynamic 0
		
	
		
				
		// use optimized fog rendering
		fast_fogvolume 1
		
		r_screen_space_shadows 0
		r_cheapshadows 1
		r_model_lighting_simplified 1


		"r_citadel_antialiasing" "0"
		"r_arealights" "false"
		
		cl_retire_low_priority_lights true
		r_multiscattering 1                                          // Enables multi-scattering lighting approximation. [def: "1"]
		r_citadel_distancefield_farfield_enable 0 // was 0
			
	
		"csm_viewmodel_shadows" "false"
		"csm_max_shadow_dist_override"	"-1"
		"csm_viewmodel_max_shadow_dist" "0"
		"csm_max_visible_dist" "0"
		"lb_csm_cascade_size_override"	"1"
		"lb_csm_draw_alpha_tested"	"0"
		"lb_csm_draw_translucent"	"0"
		"lb_csm_override_staticgeo_cascades_value"	"0"
		"lb_csm_receiver_plane_depth_bias"	"0.00002"
		"lb_csm_receiver_plane_depth_bias_transmissive_backface"	"0.0002"
		"lb_dynamic_shadow_resolution_base"	"256"
		"lb_dynamic_shadow_resolution_quantization"	"64"
		"lb_sun_csm_size_cull_threshold_texels"	"30"
		lb_enable_stationary_lights 1         // Disables stationary lights, extra lighting savings
		
		csm_max_shadow_dist_override 0        // Forces shadows to stay disabled
		cl_globallight_shadow_mode "0"                                  // \\ [def: "2"]

		"lb_barnlight_shadowmap_scale" "0"
		
		sc_disable 0
		sc_disable_shadow_materials 1         // Prevents special shadow materials from rendering
		sc_disable_spotlight_shadows 1        // Disables spotlight shadows, very expensive feature

		"mat_disable_phong"	"1"
		"mat_disable_rimlight"	"1"
		"mat_enable_uber_shaders"	1 // was "0" 	@new
		"mat_disable_lightwarp"	"1"
		"mat_mip_linear"	"0"
		"mat_reducefillrate"	"1"
		"mat_set_shader_quality"	"0"
		mat_trilinear 1 // Force trilinear as it improves texture filtering for little to no cost to performance
				

		r_lightmap_bicubic_filtering "1"                                // Bicubic filtering on lightmaps â†’ smooth baked lighting.
		"r_light_flickering_enabled" "false"
		r_lightmap_size "4"                                             // Max lightmap resolution reduced from 65536.
		r_lightmap_size_directional_irradiance "4"                      // Directional irradiance lightmap size reduced.
			
		"r_directlighting"	"0"
		
		"r_fog_enable"	"0"
		"r_shadows"	"0"
		"r_ssao"	"0"
		"r_ssao_strength"	"0"
		
		"lb_enable_dynamic_lights" "false"
		"r_dynamic_light_compile" "0"  
		"lb_enable_baked_shadows" "true"
		"lb_enable_shadow_casting"	"0"
		"r_light_static"	"1"
		"r_lightaverage"	"0"
		"lb_dynamic_shadow_resolution" "false"
		"r_rendersun" "false"
		"lb_enable_sunlight" "false"
		"lb_enable_fog_mixed_shadows" "false"
		"sc_disable_baked_lighting" "false"
		"r_directional_lightmaps" "false"
		
		// ATMOSPHERE & WATER
		r_drawskybox "0"
		r_draw3dskybox "0"
		r_monitor_3dskybox "0"
		r_3dsky 0
		r_fog_enable "0"
		r_enable_volume_fog "0"
		r_enable_gradient_fog "0"
		r_enable_cubemap_fog "0"
		volume_fog_intermediate_textures_hdr 0 // Disables HDR fog textures, reduces VRAM usage
		r_citadel_fog_quality "0"
		r_waterforceexpensive "0"
		r_drawwater "0"
		r_cheapwaterstart "1"
		r_cheapwaterend "1"
		mat_disable_water "1"
		
		/// new from last patch
		r_AirboatViewDampenDamp "1"
		r_AirboatViewDampenFreq "7"
		r_AirboatViewZHeight "0"
		r_JeepViewDampenDamp "1"
		r_JeepViewDampenFreq "7"
		r_JeepViewZHeight "10"
		r_RainAllowInSplitScreen "0"
		r_add_views_in_pre_output "0"
		
		
		r_dof_override "0"
		
		
		// POST-PROCESS
		mat_postprocess_enable 0 // was 0
		r_queued_post_processing 1 // was 1 @thread
		
		// combine post processing effects unless you have
		// these effects disabled: software AA, bloom and color correction
		mat_postprocessing_combine 1 // @new
		
		mat_hdr_level "0"
		mat_tonemapping_occlusion_use_stencil 1 // was 1
		mat_dynamic_tonemapping "0"
		mat_auto_reduce_quality "1"
		mat_auto_reduce_materials "1"
		mat_disable_bloom "1"
		mat_disable_bands "1"
		mat_disable_software_led "1"
		mat_disable_distortion "1"
		mat_disable_fancy_alpha "1"
		mat_force_bloom "0"
		mat_force_tonemap "0"
		mat_colcorrection_disableentities "1"
		mat_motion_blur_enabled "0"
		r_citadel_motion_blur "0"
		"r_citadel_ssao_thin_occluder_compensation"	"0"
		"r_citadel_ssao_bent_normals"	"false"
		"r_citadel_ssao_denoise_passes"	"0"
		"r_citadel_ssao_quality"	"0"
		"r_citadel_ssao_radius"	"0"
		r_depth_of_field "0"
		r_lensflare "0"
		r_effects_bloom "0"
		r_post_bloom "0"
		r_screenoverlay "0"
		r_filmgrain "0"
		
		r_distancefield_enable 0             // Enables distance fields (needed for outlines, low cost)
		
		r_flex "0"
		r_eyes "0"
		r_teeth  "0"
		r_eyegloss "0"
		r_eyemove "0"
		r_hair_ao "0"
		r_hair_indirect_transmittance "0" // @new
		r_hair_meshshader "0" // @new
		r_hair_shadowtile "0" // @new
		r_force_thick_hair "0" // @new
		"r_haircull_percent" "100"
		r_shadow_distance 0
		
		
		r_flashlightshadows 0
		r_flashlightdepthtexture 0
		r_flashlightmodels 0
		r_flashlightrender 0
		r_flashlightdrawfrustum 0
		
		r_flashlightambient "0"
		r_flashlightbrightness "1"
		r_flashlightfar "100"
		r_flashlightfov "90"
		r_flashlightlinear "0"

		r_citadel_motion_blur 0
		r_citadel_fog_quality 0
		r_citadel_ssao_quality 0
		r_citadel_distancefield_ao_quality 0
		r_citadel_distancefield_reflections 0
		r_citadel_distancefield_shadows 0
		"r_citadel_distancefield_down_sample" "6" //default 1
		r_effects_bloom 0
		r_post_bloom 0

		r_arealights 0
		
		r_always_render_all_windows "0"
		r_async_compute_fog "0"
		
		r_grass_allow_flattening "1"
		r_grass_density_mode "0"
		r_grass_vertex_lighting "1"

		
		r_lighting_only "0" // if 1 everything gets black 	

		
		mat_async_shader_load 0 // was 1 @thread 
		r_async_shader_compile_notify_frequency "999" // new
		mat_refraction_quality 0
		mat_clipz				1	// def. ""		# If set to 1, uses an optimization technique to reduce what is drawn on screen for a performance improvement. Note that some Nvidia FX card owners need to set mat_clipz 0 to fix rendering problems.
		mat_antialias				"0"	// def. ""		# Anti-aliasing on(1,2,4,8)/off(0) 
		mat_filtertextures			"0"	// def. "1"		# Filter textures on(1)/off(0)
		mat_forceaniso				"0"	// def. ""		# Anisotropic filtering on(1,2,4,8,16)/off(0) 
		// cull on world draw
		r_frustumcullworld 1
		// cache some world rendering
		r_worldlistcache 1
		// ensure that we're using the currently preferred rendering method
		r_drawopaquestaticpropslast 1
		// don't do software AA
		mat_software_aa_strength 0
		// don't do software AA on the HUD
		mat_software_aa_strength_vgui 0
		r_ambientboost 1
		r_ambientfactor 0
		r_ambientmin 0
		r_lightcache_zbuffercache                         1 // was 0 @new

		r_detailpropfade "0"                                            // Detail prop fade distance set to zero â†’ props vanish immediately, no fade CPU cost.
		r_displacement_mapping "0"                                      // Surface displacement/depth disabled â†’ GPU gain.
		r_drawdetailprops "0"                                           // Grass, pebbles, decorative props removed â†’ cleaner map.
		mat_filterlightmaps 0
		
		r_maxdlights				"0"	// def. "32"		# Determines the maximum number of dynamic lights visible on the screen. The larger this maximum, the more chance of slowdowns during scenes with multiple dynamic light sources. Reducing this value can improve performance in scenes with multiple dynamic lights, such as in heavy combat.

		r_hunkalloclightmaps 0 // should be fine, unless you use really big lightmaps @new
		

		r_worldlights				"0"	// def. "4"		# Number of world lights to use per vertex
		r_worldlightmin "0.0001"                                        // Minimum world light intensity clamp (very low here).     
		mat_disable_lightwarp 			"1"	// def. "0"		# UNKOWN -> Exact Effect unkown, but its a part of Phongshading. A 1D Texture for some shading.
		mat_shadowstate				"0"	// def. "1"		# noShadow(0)/circelAsShadow(1)/playerModelAsShadow(2)
		r_shadows				"0"	// def. "1"		# Shadows on(1)/off(0)
		r_shadowrendertotexture			"0"	// def. ""		# 1 = High, 0 = Low
		r_shadowmaxrendered			"0"	// def. ""		# Max. count of rendered Shadow [TF2-VideoConfigMenu: 0=min 32=High]
		mat_bumpmap				"0"	// def. ""		# Bumpmapping on(1)/off(0)
		mat_compressedtextures			1	// def. "1"		# Texturcompression on(1)/off(0) ( on(1) reduces usage of Memory in the GraphicCard but cost a little bit quality)
		mat_envmapsize				"8"	// def. "128"		# EnviromentMap -> Background Images in not reachable Sections of the Map, same as the skybox | Greater Size value better Imagequality
		mat_wateroverlaysize			"8"	// def. "128"		# Quality of reflect image in water and glass (Greater Size -> more Pixel for Detail) [to take effect r_waterdrawreflection 1]
		r_cheapwaterend				"2000"	// def. "800"		# End of the CheapWater rendering (all behind this range is black water)
		r_cheapwaterstart			"1"	// def. "500"		# Start of the CheapWater rendering (all before this range is expensive waterrendering)
		r_forcewaterleaf			"1"	// def. "1"		# Enable for optimization to water - considers view in leaf under water for purposes of culling
		r_waterdrawreflection			"0"	// def. "1"		# If set to 0, disables all reflections on top of water. Will boost performance quite noticeably in areas with water at the cost of some realism.
		r_waterdrawrefraction			 0	// def. "1"		# If set to 0, (Man kann nicht durch Wasser schauen) disables all refraction - that is images which appear distorted under the water. This will boost performance at the cost of realism, however you may experience some graphical anomalies on the water or even in the sky for some reason.
		r_waterforceexpensive			"0"	// def. ""		# 1 = High (reflect world), 0 = Low (simple reflect)
		r_waterforcereflectentities		"0"	// def. ""		# 1 = High (reflect all), 0 = Low 
		
		mat_phong "0"
		mat_grain_enable "0"
		mat_aaquality                                     "0"
		mat_antialias                                     "0"     // Anti-aliasing on(1,2,4,8)/off(0) 
		mat_autoexposure_max                              "0"
		mat_autoexposure_min                              "0"
		mat_bumpmap                                       "0"     // If set to 1, enables bump mapping which makes flat 2D textures appear three dimensional. Setting this to 0 will cause everyone to have a white shine on them.
		mat_bloomscale                                    "0"
		mat_bloom_scalefactor_scalar                      "0"
		mat_bufferprimitives                        1 // Skip flushing of primitives when meshes draw
		mat_clipz                                         "1"
		mat_compressedtextures                            "1"
		mat_disable_bloom                                 "1"
		mat_disable_fancy_blending                        "1"
		mat_motion_blur_enabled			"0"	// def. ""		# Motion Blur on(1)/off(0) 
		mat_disable_lightwarp                             "1"
		mat_debugdepthval                                 "0" 
		mat_debugdepthvalmax                              "0"
		mat_diffuse                                       "1"
		mat_envmapsize                                    "0"
		mat_envmaptgasize                                 "0"
		mat_fastspecular                                  "1"

		r_PhysPropStaticLighting		1	// def. "1"		# Static Lighting on props on(1)/off(0) 


		mat_texture_limit			"-1"	// def. "-1"		# Dont change... sets the maximal used amount of Kilobytes used for each frame when rendering. "-1" = Automatic
		mat_framebuffercopyoverlaysize                    "0"
		mat_hdr_enabled                                   "0" // Report if HDR is enabled for debugging
		mat_hdr_level                                     "0" // Set to 0 for no HDR, 1 for LDR+bloom on HDR maps, and 2 for full HDR on HDR maps.
		mat_maxframelatency                               "0"
		mat_max_worldmesh_vertices                        "0"
		mat_non_hdr_bloom_scalefactor                     "0"
		mat_parallaxmap                                   "1"

		mat_shadowstate                                   "0"
		mat_software_aa_blur_one_pixel_lines              "0"
		mat_software_aa_strength                          "0"
		mat_software_aa_strength_vgui                     "0"
		mat_software_aa_tap_offset                        "0"
		mat_softwarelighting                              "0"
		mat_specular                                      "0"
		mat_wateroverlaysize                              "0" // Sets the resolution of water distortion. Must be multiple of 8.
		
		
		r_ambientboost                                    "0"
		r_ambientmin                                      "0"
		r_ambientfactor                                   "0"
		r_bloomtintg                                      "0"
		r_bloomtintb                                      "0"
		r_bloomtintexponent                               "0"
		r_bloomtintr                                      "0"
		
		"r_morphing_enabled" 0 
		"r_smooth_morph_normals" "0"
		
		shaderquality 0
		r_shadow_half_update_rate "1"
		
		r_deferred_height_fog "0"
		r_deferred_simple_light "0"

		cl_globallight_shadow_mode "0"
		r_screenspace_aa "0"
		r_deferred_additive_pass "0"
		
		r_deferred_specular_bloom "0"
		r_deferred_specular 1 // @changed
		r_shadowtile_waveops "0"
		r_show_gpu_memory_visualizer "0"
		r_showdebugrendertarget "0"
		r_showsunshadowdebugrendertargets "0"
		r_showsunshadowdebugsplitvis "0"
		r_suppress_redundant_state_changes "1" // was 1
		r_vma_defrag_enabled 1 // no defrag if 0

		//<<< ==================  RENDERING ==================
		
		//>>> ================ SYSTEM RELATED ================ 
		gpu_level 2                                                   // GPU level. [def: "3"]
		gpu_mem_level 1                                               // GPU Memory level. [def: "2"]
		cpu_level 	2                                                 // CPU level. [def: "2"]// 2 = best balance on modern CPUs. Lower to 0–1 only if CPU is weak or you get stutter.
		mem_level 1
	
		battery_saver "0"                                               // Disables battery saver mode (no automatic throttling). [def: "0"]
		//<<< ================ SYSTEM RELATED ================ 	
		
		//>>>  ================ VISUAL CLARITY ================ 
		mat_colorcorrection "1"                                         // Disables/ Enables color correction (game looks less vibrant when off). [def: "1"]
		"cl_impacteffects" "0"
		cl_show_splashes "0"                                            // Disables splash effects (water/impact splashes). [def: "1"]
		violence_hblood "0"                                             // Disables human blood effects. [def: "1"]
		violence_ablood "0"                                             // Disables alien/other blood effects. [def: "1"]
		violence_hgibs "0"                                              // Disables human gibs. [def: "1"]
		violence_agibs "0"                                              // Disables alien/other gibs. [def: "1"]
		sc_clutter_enable "0"                                           // Disables clutter props, improves visibility & FPS. [def: "1"]
		sc_cache_envmap_lpv_lookup "1"
		cl_show_bloodspray "0" // 0
		cl_burninggibs "0"
		//<<< ================ VISUAL CLARITY ================ 
		
		//>>> ================ AUDIO ================
		
		// "snd_mixahead" "0.04" //set to 0.001 if have good CPU, 0.05 adds 50ms to audio mixing thus save CPU perf, should not be perceiveable by any human. 
		"audio_enable_vmix_mastering" "0"     // [FPS IMPACT] 0=Off (saves CPU, +FPS) | 1=On (audio mastering enabled)"
		"dsp_volume" "0"                    // idk
		"disable_source_soundscape_trace"       "1"
		"snd_occlusion_bounces" "0"
		// "snd_steamaudio_num_threads" 1   // was 1/ [ADJUST] Audio thread count - 1=Low CPU usage | Higher = better audio quality, more CPU By default, it might only use 1 thread. Increasing this allows the heavy sound math to spread out, preventing it from stalling the main game loop during loud teamfights // @thread
		"snd_mix_async" 1 // was 1 // @thread
		"soundsystem_update_async" 1 // was 1 @thread
		
		"audio_relevance_debug_enabled"	"0"	// Audio relevance debugging
		"snd_envelope_rate"	"100.0"
		"snd_event_browser_default_stack" "citadel_default_3d"
		"snd_event_browser_focus_events"	"true"
		
		"snd_sos_max_event_base_depth"	"10"
		"snd_sound_areas_debug"	"0"	// Sound area debugging
		
		"snd_soundmixer"	"Default_Mix"
		"snd_soundmixer_update_maximum_frame_rate"	"0"
		
		"snd_steamaudio_active_hrtf"	"0"
		"snd_steamaudio_enable_custom_hrtf"	"0"
		"snd_steamaudio_enable_pathing"	"0"
		"snd_steamaudio_invalid_path_length"	"0.0"
		"snd_steamaudio_ir_duration"	"1.0"
		
		"snd_event_cone_debug"	"0"	// Sound cone debugging
		"snd_occlusion_debug"	"0"	// Sound occlusion debugging
		"snd_report_audio_nan"	"1"
		
		


		"snd_steamaudio_reverb_update_rate"	"10.0"
		snd_ui_positional	"1"
		snd_ui_spatialization_spread "2.4"
		sos_use_guid_filter	"1"
		
		"voice_in_process"	"1"
		"voice_input_stallout"	"0.5"
		"update_voices_low_priority" 1 //default false 
		//<<< ================ AUDIO ================
		
		//>>> ==================  DAMAGE NUMBERS & UI ================== 
		r_citadel_enable_pano_world_blur 			"false"
		
		"panorama_allow_transitions" "false"
		"panorama_disable_render_target_cache" "0"
		"panorama_transition_time_factor" "1" //faster transition for the stuff that doesnt use animation
		
		// Enable the composition layer optimization
		"panorama_skip_composition_layer_content_paint" "1"
		panorama_composition_atlas true // was false
		"panorama_joystick_enabled"	"0"
		"panorama_js_minidumps"	"0"
		
		"sc_clutter_density_none_size" 0.0035 // was 1.9 Default 0.0035
					
	
		"citadel_damage_indicator"	"0"
		"citadel_damage_overlay"	"0"
		"citadel_damage_report_enable"	"1"	// Damage report, enable 1 to see report
		"citadel_damage_screen_effects"	"1"
		"citadel_damage_text_show_effectiveness"	"0"	// Damage effectiveness in text
		"citadel_enemy_glow_enabled"	"0"
		"citadel_hud_objective_health_enabled"	"2"	// 0=Off, 1=Shrines, 2=T1/T2, 3=Barracks 0 = off, 1 = shrines, 2 = T1/T2, 3 = barracks
		"citadel_minimap_draw_fow"	"0"	// Fog of war on map
		"citadel_minimap_show_hitboxes"	"0"	// Hitboxes on map
		"citadel_minimap_use_canvas_for_neutrals"	"0"	// Neutrals on minimap
		"citadel_minimap_use_canvas_for_shop"	"0"	// Shops on minimap
		"citadel_minimap_use_effects"	"0"	// Minimap effects
		
		r_citadel_npr_outlines_max_dist 			"600"			// Limits outline distance to reduce unnecessary processing.
		

		r_citadel_npr_force_solid_outline "0"
		r_citadel_selection_outline2_alpha "0.8"

		"citadel_boss_glow_disabled"	"1"	// Boss highlights
		"citadel_player_glow_disabled"	 "1"	///default false, breaks backstabber
		"citadel_trooper_friendly_glow_disabled"	"1"	// 1 = Disable friendly trooper glow
		"citadel_trooper_glow_disabled"	"1"	// 1 = Disable enemy trooper glow
		r_citadel_outlines "0" 
			
		cl_playerspraydisable "1"
		
		// UI

		"r_dashboard_render_quality" "0"
		
		"citadel_damage_offscreen_indicator_disabled" 1 // Set 1 to disable
		"citadel_portrait_world_renderer_off" "false" // Set true to disable hero hud
		
		"panorama_worldpanel_update_culling" "true"
		"panorama_worldpanel_update_cull_distance" "5000"
		"panorama_worldpanel_update_cull_size_threshold" "5"
		
		"panorama_classes_perf_warning_threshold_ms"	"0.75"
		"panorama_disable_animations"	"1"
		panorama_disable_box_shadow 1         // Disables UI shadows, saves UI render cost
		"panorama_use_new_occlusion_invalidation" "1" // 1
		"panorama_temp_comp_layer_min_dimension" "128"
		"panorama_max_overlay_fps" "15"
		"panorama_max_fps" "15"               // [ADJUST] UI FPS cap - 0=Unlimited (smooth UI) | 30/60=Standard | Higher = smoother HUD but more CPU
		"panorama_async_compute_mipgen" "1" // @thread
		
		// "hud_free_cursor" "0"                // Reduces UI input delay in minimap/spectator modes (not sure if this is true)
		"citadel_camera_soft_collision" "0"
		"citadel_camera_wobble_disable" "1"
		"mm_idle_show_warning_at_s" "999"   // How many seconds to wait before showing the idle warning dialog
		"citadel_hideout_ball_show_juggle_count" "1"
		"citadel_hideout_ball_show_juggle_fx" "1"
	

		citadel_post_damage_vignette 0
		citadel_use_vertical_healthbars "0" // ugly if 1
		
		panorama_disable_blur "1"
		panorama_disable_parallax "1"
		panorama_disable_text_shadow "1"
		
		// citadel_crosshair_hit_marker_duration 0 // @new
		//<<< ==================  DAMAGE NUMBERS & UI ================== 
		
		//>>> ================  OTHER  ================
		r_threaded_client_shadow_manager 1 // @thread
		r_threaded_scene_object_update 1 // new @thread @here
		
		"imgui_debug_draw_dashboard_window"	"0"	// ImGui dashboard rendering
		"imgui_enable"	"0"	// ImGui enable
		"imgui_enable_input"	"0"	// ImGui input
		"imgui_temp_enable"	"0"	// Temporary ImGui
		"in_button_double_press_window"	"0.3"
		"input_virtualization_block_mouse"	"1"
		
		// Reduce background work
		cl_autohelp 0
		cl_showhelp 0
		cl_disablefreezecam 0
		
		"cl_joystick_enabled"	"0"
		"cl_disconnect_soundevent"	"citadel.convar.stop_all_game_layer_soundevents"
		"cl_ejectbrass"	"0"
		
		m_mouseaccel1 "0"                                               // Windocl_particle_retire_cosws acceleration threshold 1 disabled â†’ preserves muscle memory.
		m_mouseaccel2 "0"                                               // Windows acceleration threshold 2 disabled â†’ preserves muscle memory.
		m_mousespeed "0"                                                // Windows pointer speed effect nullified â†’ consistent aim.
		
		// "host_thread_mode"	 0 // @thread
				
		enable_priority_boost "1" 
		
		// in_usekeyboardsampletime 0	
		r_norefresh 0 // was 1 Do not store a useless and unused frame time variable @new
		mat_requires_rt_alloc_first 0 // Force disable, since new GPUs do not need to do this. Improves load times.
		sys_minidumpspewlines 0 // Do not save any console output to a memory buffer in case of a crash
		mat_powersavingsmode 0
		minimap_update_rate_hz 15
		r_flush_on_pooled_ib_resize false
		cl_trueview_show_status 0
		// cl_hold_game_events_until_server_tick false // Def: true @change
		//<<< ================  OTHER  ================
		
		////////////////// TESTING @changed ALL
		// phys_expensive_shape_threshold                                                   1 // : 6                : cl, cheat                        : 
		// phys_use_block_solver                                                            0 // : true             : sv, cheat                        : Use block solving for constraint entities
		
		// mat_max_lighting_complexity   1 // Def : 8                : cheat                            : 
                // mat_shading_complexity_max_instruction_count  2048  // Def : 1024             : cheat                            : 
		//  mat_shading_complexity_max_register_count                                        : 128              : cheat                            : 
		// mat_shadowmap_luxels                                                             : false            : cheat                           
		
		fog_enable                    false // : true             : cl, cheat                        : Enable fog
		fog_enableskybox         false // Def: true

		mesh_calculate_curvature_smooth_pass_count              0 // : 3                : sv, cl, rep, cheat               : 
		mesh_calculate_curvature_smooth_weight                       0 //  1                : sv, cl, rep, cheat               : 
		
		// sc_force_lod_level                                                               2 // : -1               : cheat      
		// sc_force_translation_in_projection                                         1 //      : false            : cheat                            : If enabled, the camera's translation will be included in the projection matrix.
		// sc_screen_size_lod_scale_override                                    0.06 // : 0.01             : cheat                            : 
			

		

		

		
		// ==========================================================  //
		// ================ CLEAN CONFIG BELLOW ====================  //
		// ========================================================== //
		"rate"
		{
			"min"		"98304"
			"default"	 "786432"
			// "default"	 1000000
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
		// "iv_parallel_restore" "1"

		// For perf reasons, since we don't use source-based DSP:
		"disable_source_soundscape_trace"       "1"
		
		// Networking - Induced latency (pred offset)
		"cl_tickpacket_recvmargin_desired" 6					// was 5 ms base, min. floor for protecting against thrashing the queue
		"cl_tickpacket_desired_queuelength" "0"					// 0 = attempt to always reach the queue's min floor
		"cl_async_usercmd_send_disabled_recvmargin_min" "0.5"	// Additional frame since we do not use the async usercmd send (potentially unneccessary)
		"cl_clock_buffer_ticks"	1 // Def: "1"
		// "cl_interp_ratio" "0"
		"cl_async_usercmd_send" false // Def: "false"

		"fps_max"		"400"
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

		"cq_buffer_bloat_msecs_max" "240" // Def: 120
 
		"snd_soundmixer"						"Default_Mix"
		"cloth_filter_transform_stateless" "0"

		"cl_joystick_enabled" "0"
		"panorama_joystick_enabled" "0"

		"snd_event_browser_focus_events" "true"

		// "cl_max_particle_pvs_aabb_edge_length" "100"
		
		// Allow aggregation of particles (for perf)
		// "cl_aggregate_particles" "true"
		
		"citadel_enable_vdata_sound_preload" "true"
	}

	Memory
	{
		"EstimatedMaxCPUMemUsageMB"	"1"
		"EstimatedMinGPUMemUsageMB"	"1"

		"ShowInsufficientPageFileMessageBox" "1"
		"ShowLowAvailableVirtualMemoryMessageBox" "1"
	}
}
