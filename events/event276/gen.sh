lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.16836836836837 --fixed-mass2 57.669069069069074 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009908143.0321597 \
--gps-end-time 1009915343.0321597 \
--d-distr volume \
--min-distance 1757.3115557709166e3 --max-distance 1757.3315557709166e3 \
--l-distr fixed --longitude -14.2850341796875 --latitude 14.595879554748535 --i-distr uniform \
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
