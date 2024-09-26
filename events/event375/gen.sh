lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.429029029029028 --fixed-mass2 68.09053053053053 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014961153.094451 \
--gps-end-time 1014968353.094451 \
--d-distr volume \
--min-distance 1220.3305982720756e3 --max-distance 1220.3505982720756e3 \
--l-distr fixed --longitude 84.00785827636719 --latitude 71.9783706665039 --i-distr uniform \
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
