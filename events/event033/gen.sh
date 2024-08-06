lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.50702702702703 --fixed-mass2 12.201241241241242 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023506055.4557598 \
--gps-end-time 1023513255.4557598 \
--d-distr volume \
--min-distance 990.2442674148643e3 --max-distance 990.2642674148643e3 \
--l-distr fixed --longitude -26.570404052734375 --latitude -72.70101165771484 --i-distr uniform \
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
