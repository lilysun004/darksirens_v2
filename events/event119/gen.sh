lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 15.983223223223224 --fixed-mass2 61.703183183183185 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004981300.805234 \
--gps-end-time 1004988500.805234 \
--d-distr volume \
--min-distance 1606.0049293201296e3 --max-distance 1606.0249293201296e3 \
--l-distr fixed --longitude -141.5 --latitude 60.67349624633789 --i-distr uniform \
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
