lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 32.28776776776777 --fixed-mass2 82.79823823823824 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001116041.4280995 \
--gps-end-time 1001123241.4280995 \
--d-distr volume \
--min-distance 2468.55835870344e3 --max-distance 2468.5783587034402e3 \
--l-distr fixed --longitude -171.53298950195312 --latitude 21.94337272644043 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
