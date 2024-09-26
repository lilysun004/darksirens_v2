lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.89189189189189 --fixed-mass2 24.303583583583585 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007108378.3922518 \
--gps-end-time 1007115578.3922518 \
--d-distr volume \
--min-distance 1381.980033063999e3 --max-distance 1382.000033063999e3 \
--l-distr fixed --longitude -127.42471313476562 --latitude -29.484270095825195 --i-distr uniform \
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
