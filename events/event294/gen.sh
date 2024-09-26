lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 79.60456456456457 --fixed-mass2 82.46206206206206 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007449199.7529923 \
--gps-end-time 1007456399.7529923 \
--d-distr volume \
--min-distance 2863.982285496025e3 --max-distance 2864.0022854960253e3 \
--l-distr fixed --longitude -160.31158447265625 --latitude -2.420398235321045 --i-distr uniform \
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
