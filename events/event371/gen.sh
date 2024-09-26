lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.89189189189189 --fixed-mass2 67.082002002002 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015312181.6118387 \
--gps-end-time 1015319381.6118387 \
--d-distr volume \
--min-distance 1971.3747249370556e3 --max-distance 1971.3947249370556e3 \
--l-distr fixed --longitude -39.458740234375 --latitude -15.061386108398438 --i-distr uniform \
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
